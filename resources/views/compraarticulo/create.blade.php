@extends('welcome')
@section('content')


<style>
    #scrollable-dropdown-menu .tt-dropdown-menu {
        max-height: 150px;
        overflow-y: auto;
    }


    .twitter-typeahead, .tt-hint, .tt-input, .tt-menu { width: 100%; }
</style>

<script src="https://cdnjs.cloudflare.com/ajax/libs/livequery/1.1.1/jquery.livequery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/corejs-typeahead/1.3.0/typeahead.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/corejs-typeahead/1.3.0/typeahead.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootbox.js/5.4.0/bootbox.min.js"></script>


<script type="text/javascript">

        $(document).ready(function(){
            var i=0;
            $("#add_row").click(function(){
                b=i-1;
                $('#addr'+i).html($('#addr'+b).html()).find('td:first-child').html(i+1);
                $('#tab_logic').append('<tr id="addr'+(i+1)+'"></tr>');
                i++;
            });
            $("#delete_row").click(function(){
                console.log(i);
                if(i>1){
                    $("#addr"+(i-1)).html('');
                    i--;
                }
                calc();
            });

            $('#tab_logic tbody').on('keyup change',function(){
                calc();
            });
            $('#tax').on('keyup change',function(){
                calc_total();
            });



            // Set the Options for "Bloodhound" suggestion engine
            var engine = new Bloodhound({
                remote: {
                    url: '/productos?q=QUERY',
                    wildcard: 'QUERY'
                },
                datumTokenizer: Bloodhound.tokenizers.whitespace('NombreArticulo'),
                queryTokenizer: Bloodhound.tokenizers.whitespace
            });
          //  console.log(engine);

            $("#buscarArticulo").typeahead({
                hint: true,
                highlight: true,
                limit: 10,
                minLength: 2
            }, {
                source: engine.ttAdapter(),
                display: 'NombreArticulo',

                // This will be appended to "tt-dataset-" to form the class name of the suggestion menu.
                name: 'listaArticulos',

                // the key from the array we want to display (name,id,email,etc...)
                templates: {
                    empty: [
                        '<div class="list-group search-results-dropdown"><div class="list-group-item">Registro no encontrado</div></div>'
                    ],
                    header: [
                        '<div class="list-group search-results-dropdown">'
                    ],
                    suggestion: function (data) {
                      //  console.log("datos del servidor : ");
                        //console.log(data);
                        //return '<a href="' + data.NombreArticulo + '" class="list-group-item">' + data.NombreArticulo + ' - @' + data.NombreArticulo + '</a>'
                        return ('<div class="list-group-item" >' + data.NombreArticulo + '</div>');
                        // return  data.NombreArticulo;
                    }
                }
            }).on('typeahead:selected', function(event, data) {
                // console.log("seleccionado");
                // console.log(data.NombreArticulo);
                //$('.search-inputs').val(data.NombreArticulo);

                var name = data.NombreArticulo;
                var codigo = data.NombreArticulo;
                var precio = data.PrecioVigente;

                dato = existeTupla('', data.IdArticulo);
                if(dato == true)
                {
                    bootbox.alert("El articulo <strong> \"" + name + "\" </strong>ya se encuentra en el detalle");
                    return;
                }
                var markup = "<tr id=addr" +(i+1)+">" +
                    "<td>" +(i+1)+" </td>"+
                    "<td><input type='text' name='productos[]' class='form-control' value ='"+ name+"'  readonly/></td>" +
                    "<td><input type='number' name='cantidades[]' class='form-control qty' step='1' value ='1' ></td>" +
                    "<td><input type='number' name='precios[]' placeholder='Int. Precio Unitario' class='form-control price' step='0.00' min='0' value='"+precio +"'> </td>" +
                    "<td><input type='number' name='total[]' placeholder='0.00' class='form-control total'  value='"+precio +"' readonly/></td>"+
                    "<td data-name='del" +(i+1)+"'><button onclick='removeRow("+(i+1)+");' name='del" +(i+1)+"' class='btn btn-danger glyphicon glyphicon-remove row-remove'><span aria-hidden='true'>×</span></button></td>"+
                    "<td style='display:none'> <input name='codigos[]' value='"+data.IdArticulo +"'> </td>"+

                "</tr>";
                $('#tab_logic').append(markup);
                calc_total();


                i++;




            });

            var proveedores = new Bloodhound({
                remote: {
                    url: '/buscarproveedoresAjax?q=QUERY',
                    wildcard: 'QUERY'
                },
                datumTokenizer: Bloodhound.tokenizers.whitespace('NombreRazonSocial'),
                queryTokenizer: Bloodhound.tokenizers.whitespace
            });
           // console.log(proveedor);

            $("#buscarProveedor").typeahead({
                hint: true,
                highlight: true,
                limit: 10,
                minLength: 2
            }, {
                source: proveedores.ttAdapter(),
                display: 'NombreRazonSocial',

                // This will be appended to "tt-dataset-" to form the class name of the suggestion menu.
                name: 'listaClientes',

                // the key from the array we want to display (name,id,email,etc...)
                templates: {
                    empty: [
                        '<div class="list-group search-results-dropdown"><div class="list-group-item">Proveedor no encontrado</div></div>'
                    ],
                    header: [
                        '<div class="list-group search-results-dropdown">'
                    ],
                    suggestion: function (data) {

                        return ('<div class="list-group-item" >' + data.NombreRazonSocial + '</div>');
                    }
                }
            }).on('typeahead:selected', function(event, data) {
                var nombreCompleto = data.NombreRazonSocial;
                var IdProveedor = data.IdProveedor;

              //  console.log("Cliente "  + nombreCompleto + ", ID" + IdProveedor);

                $('#CompraArticulos input[name=\"IdProveedor\"]').val(IdProveedor)


            });



        });

        function removeRow(removeNum) {
            jQuery('#addr'+removeNum).remove();
            calc_total();
        }
        function calc()
        {
            $('#tab_logic tbody tr').each(function(i, element) {
                var html = $(this).html();
                if(html!='')
                {
                    var qty = $(this).find('.qty').val();
                    var price = $(this).find('.price').val();
                    $(this).find('.total').val(qty*price);

                    calc_total();
                }
            });
        }

        function calc_total()
        {
            total=0;
            $('.total').each(function() {
                total += parseInt($(this).val());
            });
            $('#sub_total').val(total.toFixed(2));
            tax_sum=total/100*$('#tax').val();
            $('#tax_amount').val(tax_sum.toFixed(2));
            $('#total_amount').val((tax_sum+total).toFixed(2));
        }

        function existeTupla(that, id) {

            console.log("buscando dublicados");
            var table = document.getElementById("tab_logic");

            /*
            Extract and iterate rows from tbody of table2
            */
            for(const tr of table.querySelectorAll("tbody tr")) {

                /*
                Extract first and second cell from this row
                */
                const td0 = tr.querySelector("td:nth-child(7)");
               // const td1 = tr.querySelector("td:nth-child(2)");
                //console.log(td0.innerHTML  + "  == " + id);



                var innerObj = td0.innerHTML;
                var index = innerObj.indexOf("value=");
                var objValue = "";
                if(index>0){
                    index+=7;
                    var tempStr = innerObj.substring(index,innerObj.lenght);
                    var tempIndex = tempStr.indexOf("\"");
                    tempIndex+=index;
                    objValue = innerObj.substring(index,tempIndex).trim();
                    //alert("value = "+objValue);
                    console.log(objValue  + "==" + id);
                }




                /*
                If this row has missing cells, skip it
                */
                if(!td0 ) {
                    continue;
                }

                /*
                Check if cells of existing tr row contain same contents
                as input arguments. Note also the use of == rather than
                the use of === to allow type coercion when comparing
                number id with string id.
                */
                if ((objValue == id) ) {

                    console.log(`Match found for ${id} . Insert rejected`);
                    return true;
                }
            }

            // var row = table.insertRow(1);
            // var cell1 = row.insertCell(0);
            // var cell2 = row.insertCell(1);
            //
            // cell1.innerHTML = id;
            // cell2.innerHTML = name;
            return false;
        }


    </script>


















    <form action="{{ route("comprasarticulos.store") }}" method="POST" id="CompraArticulos">
        @csrf


        <div class="card mt-2 mb-2">
            <div class="card-header bg-secondary text-white">Datos Generales</div>
            <div class="card-body">
                <div class="form-row col-md-12">

                    <div class="form-group col-md-6">
                        <label for="buscarProveedor" >Seleccione Proveedor<span class="text-danger" >*</span></label>
                        <input type="search" name="NombreRazonSocial" class="form-control typeahead" placeholder="Proveedor" autocomplete="off" id="buscarProveedor" required value="{{old('NombreRazonSocial','Por Defecto')}}" VALUE ="1">
                        <div class="invalid-feedback">
                            Porfavor seleccione un proveedor.
                        </div>


                        <input type="hidden" name="IdProveedor"   value="{{old('IdProveedor', 7)}}" />

                    </div>

                    <div class="form-group col-md-3">
                        <label for="FechaHoraRegistro">Fecha Registro<span class="text-danger">*</span></label>
                        <input type="date" name="FechaHoraRegistro" id="FechaHoraRegistro" class="form-control"  required  value="{{ \Carbon\Carbon::now()->format('Y-m-d')}}" readonly>
                    </div>
                </div>



{{--                <div class="form-group col-md-6">--}}
{{--                    <label for="CodigoEstadoVenta">Estado Compra<span class="text-danger">*</span></label>--}}
{{--                    --}}{{--                    <input type="input" name="CodigoEstadoVenta" id="CodigoEstadoVenta" class="form-control"  required  value="INICIADO" readonly>--}}
{{--                    <select id="CodigoEstadoVenta" class="form-control" name="CodigoEstadoVenta" >--}}
{{--                        <option value="I" selected>INICIADO</option>--}}
{{--                        <option value="A">ANULADO</option>--}}
{{--                        <option value="F">FINALIZADO</option>--}}

{{--                    </select>--}}

{{--                </div>--}}

                <div class="form-group col-md-9">
                    <label for="Observaciones">Observaciones</label>
                    <textarea class="form-control" id="Observaciones" rows="2" name="Observaciones" cols="100"> {{old('Observaciones')}} </textarea>
                </div>

            </div>
        </div>

        <div class="card mt-2 mb-2">
            <div class="card-header bg-secondary text-white">Detalles de Compra</div>
            <div class="card-body">
                <div class="row clearfix">
                    <div class="form-group col-sm-10">
{{--                        <input type="search" name="q" class="form-control typeahead" placeholder="Int. Articulo" autocomplete="off">--}}
                        <input type="search" id="buscarArticulo" name="articulo" class="form-control typeahead" placeholder="Int. Articulo" autocomplete="off" >
                    </div>
                </div>

                <div class="row clearfix">
                    <div class="col-md-12">
                        <table class="table table-bordered table-hover" id="tab_logic">
                            <thead>
                            <tr>
                                <th class="text-center"> Id</th>
                                <th class="text-center"> Articulo</th>
                                <th class="text-center"> Cantidad</th>
                                <th class="text-center"> Precio</th>
                                <th class="text-center"> Total</th>
                                <th class="text-center" style="border-top: 1px solid #f8f9fc; border-right: 1px solid #f8f9fc; border-bottom: 1px solid #f8f9fc;"></th>
                                <th class="text-center" style='display:none'></th>
                            </tr>
                            </thead>
                            <tbody>
                            {{--                    <tr id='addr0'>--}}
                            {{--                        <td>1</td>--}}
                            {{--                        <td>--}}


                            {{--                            <input type="text" name='product[]' placeholder='Int. articulo' class="typeahead form-control"/>--}}

                            {{--                            <input class="typeahead form-control" type="text" name='articulos[]'>--}}
                            {{--                        </td>--}}
                            {{--                        <td><input type="number" name='cantidades[]' placeholder='Int. Cantidad' class="form-control qty" step="0" value ="1"--}}
                            {{--                                   min="0"/></td>--}}
                            {{--                        <td><input type="number" name='precios[]' placeholder='Int. Precio Unitario'--}}
                            {{--                                   class="form-control price" step="0.00" min="0"/></td>--}}
                            {{--                        <td><input type="number" name='total[]' placeholder='0.00' class="form-control total" readonly/>--}}
                            {{--                        </td>--}}
                            {{--                    </tr>--}}

                            {{--                    <tr id='addr1'></tr>--}}
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row clearfix" style="margin-top:20px">
                    <div class="ml-auto col-md-4">
                        <table class="table table-bordered table-hover" id="tab_logic_total">
                            <tbody>
                            <tr>
                                <th class="text-center">Sub Total</th>
                                <td class="text-center"><input type="number" name='sub_total' placeholder='0.00'
                                                               class="form-control" id="sub_total" readonly/></td>
                            </tr>
                            <tr>
                                <th class="text-center">Tax</th>
                                <td class="text-center">
                                    <div class="input-group mb-2 mb-sm-0">
                                        <input type="number" class="form-control" id="tax" placeholder="0">
                                        <div class="input-group-addon">%</div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="text-center">Tax Amount</th>
                                <td class="text-center"><input type="number" name='tax_amount' id="tax_amount"
                                                               placeholder='0.00' class="form-control" readonly/></td>
                            </tr>
                            <tr>
                                <th class="text-center">Grand Total</th>
                                <td class="text-center"><input type="number" name='total_amount' id="total_amount"
                                                               placeholder='0.00' class="form-control" readonly/></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>


            </div>
        </div>



        <div class="row">
            <input class="ml-auto btn btn-danger" type="submit" value="Guardar">
        </div>
    </form>

@endsection


