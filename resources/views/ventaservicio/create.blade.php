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
            var NroArticulos=0;
            var NroServicios = 0;
            var NroClientes = 0;


            $('#tabla_servicios tbody').on('keyup change',function(){
                calc();
            });
            $('#tax').on('keyup change',function(){
                calc_total();
            });



            // Set the Options for "Bloodhound" suggestion engine
            var articulos = new Bloodhound({
                remote: {
                    url: '/buscarproductosAjax?q=QUERY',
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
                source: articulos.ttAdapter(),
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
                var markup = "<tr id=articulo" +(NroArticulos+1)+">" +
                    "<td>" +(NroArticulos+1)+" </td>"+
                    "<td><input type='text' name='productos[]' class='form-control' value ='"+ name+"'  readonly/></td>" +
                    "<td><input type='number' name='cantidades[]' class='form-control qty' step='1' value ='1' ></td>" +
                    "<td><input type='number' name='precios[]' placeholder='Int. Precio Unitario' class='form-control price' step='0.00' min='0' value='"+precio +"'> </td>" +
                    "<td><input type='number' name='total[]' placeholder='0.00' class='form-control total'  value='"+precio +"' readonly/></td>"+
                    "<td data-name='del" +(NroArticulos+1)+"'><button onclick='removeRow("+(NroArticulos+1)+");' name='del" +(NroArticulos+1)+"' class='btn btn-danger glyphicon glyphicon-remove row-remove'><span aria-hidden='true'>×</span></button></td>"+
                    "<td style='display:none'> <input name='codigos[]' value='"+data.IdArticulo +"'> </td>"+

                    "</tr>";
                $('#tabla_articulos').append(markup);
                calc_total();


                NroArticulos++;




            });




            var clientes = new Bloodhound({
                remote: {
                    url: '/buscarclientesAjax?q=QUERY',
                    wildcard: 'QUERY'
                },
                datumTokenizer: Bloodhound.tokenizers.whitespace('NombreCompleto'),
                queryTokenizer: Bloodhound.tokenizers.whitespace
            });
              console.log(clientes);



            $("#buscarCliente1").typeahead({
                hint: true,
                highlight: true,
                limit: 10,
                minLength: 2
            }, {
                source: clientes.ttAdapter(),
                display: 'NombreCompleto',

                // This will be appended to "tt-dataset-" to form the class name of the suggestion menu.
                name: 'listaClientes',

                // the key from the array we want to display (name,id,email,etc...)
                templates: {
                    empty: [
                        '<div class="list-group search-results-dropdown"><div class="list-group-item">Cliente no encontrado</div></div>'
                    ],
                    header: [
                        '<div class="list-group search-results-dropdown">'
                    ],
                    suggestion: function (data) {

                        return ('<div class="list-group-item" >' + data.NombreCompleto + '</div>');
                    }
                }
            }).on('typeahead:selected', function(event, data) {
                var nombreCompleto = data.NombreCompleto;
                var IdCliente = data.IdCliente;


                $('#VentaServicios input[name=\"IdCliente\"]').val(IdCliente)


            });


            $("#buscarCliente2").typeahead({
                hint: true,
                highlight: true,
                limit: 10,
                minLength: 2
            }, {
                source: clientes.ttAdapter(),
                display: 'NombreCompleto',

                // This will be appended to "tt-dataset-" to form the class name of the suggestion menu.
                name: 'listaClientes',

                // the key from the array we want to display (name,id,email,etc...)
                templates: {
                    empty: [
                        '<div class="list-group search-results-dropdown"><div class="list-group-item">Cliente no encontrado</div></div>'
                    ],
                    header: [
                        '<div class="list-group search-results-dropdown">'
                    ],
                    suggestion: function (data) {

                        return ('<div class="list-group-item" >' + data.NombreCompleto + '</div>');
                    }
                }
            }).on('typeahead:selected', function(event, data) {
                var nombreCompleto = data.NombreCompleto;
                var IdCliente = data.IdCliente;
                var NroVisitas = data.NroVisitas;

                var markup = "<tr id=cliente" +(NroClientes+1)+">" +
                    "<td>" +(NroClientes+1)+" </td>"+
                    "<td>" +nombreCompleto+" </td>"+
                    "<td>" +NroVisitas+" </td>"+
                    "<td data-name='del" +(NroClientes+1)+"'><button onclick='removeRow("+(NroClientes+1)+");' name='del" +(NroClientes+1)+"' class='btn btn-danger glyphicon glyphicon-remove row-remove'><span aria-hidden='true'>×</span></button></td>"+
                    "<td style='display:none'> <input name='codigos_clientes[]' value='"+IdCliente +"'> </td>"+

                    "</tr>";
                $('#tabla_clientes').append(markup);

                NroClientes++;


            });

            //buscarServicio

            var servicios = new Bloodhound({
                remote: {
                    url: '/buscarserviciosAjax?q=QUERY',
                    wildcard: 'QUERY'
                },
                datumTokenizer: Bloodhound.tokenizers.whitespace('NombreServicio'),
                queryTokenizer: Bloodhound.tokenizers.whitespace
            });
            console.log(servicios);

            $("#buscarServicio").typeahead({
                hint: true,
                highlight: true,
                limit: 10,
                minLength: 2
            }, {
                source: servicios.ttAdapter(),
                display: 'NombreServicio',

                // This will be appended to "tt-dataset-" to form the class name of the suggestion menu.
                name: 'listaServicios',

                // the key from the array we want to display (name,id,email,etc...)
                templates: {
                    empty: [
                        '<div class="list-group search-results-dropdown"><div class="list-group-item">Servicio no encontrado</div></div>'
                    ],
                    header: [
                        '<div class="list-group search-results-dropdown">'
                    ],
                    suggestion: function (data) {

                        return ('<div class="list-group-item" >' + data.NombreServicio + '</div>');
                    }
                }
            }).on('typeahead:selected', function(event, data) {
                var NombreServicio = data.NombreServicio;
                var IdServicio = data.IdServicio;
                var CostoServicio = data.CostoServicio;

                var markup = "<tr id=servicio" +(NroServicios+1)+">" +
                    "<td>" +(NroServicios+1)+" </td>"+
                    "<td><input type='text' name='servicios[]' class='form-control' value ='"+ NombreServicio+"'  readonly/></td>" +
                    "<td><input type='input' name='cantidades_servicios[]' class='form-control qty' step='1' value ='1' readonly></td>" +
                    "<td><input type='input' name='precios_servicios[]' placeholder='Int. Precio Unitario' class='form-control price' step='0.00' min='0' value='"+CostoServicio +"' readonly> </td>" +
                    "<td><input type='input' name='total_servicios[]' placeholder='0.00' class='form-control total'  value='"+CostoServicio +"' readonly/></td>"+
                    "<td data-name='del" +(NroServicios+1)+"'><button onclick='removeRow("+(NroServicios+1)+");' name='del" +(NroServicios+1)+"' class='btn btn-danger glyphicon glyphicon-remove row-remove'><span aria-hidden='true'>×</span></button></td>"+
                    "<td style='display:none'> <input name='codigos_servicios[]' value='"+IdServicio +"'> </td>"+

                    "</tr>";
                $('#tabla_servicios').append(markup);
                calc_total();

                NroServicios++;

            });



        });

        function removeRow(removeNum) {
            jQuery('#servicio'+removeNum).remove();
            calc_total();
        }
        function calc()
        {
            $('#tabla_servicios tbody tr').each(function(i, element) {
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
            var table = document.getElementById("tabla_servicios");

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
<div class="row">
    <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
        <li class="nav-item">
            <a class="nav-link active" id="pills-general-tab" data-toggle="pill" href="#pills-general" role="tab" aria-controls="pills-home" aria-selected="true">General</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="pills-servicios-tab" data-toggle="pill" href="#pills-servicios" role="tab" aria-controls="pills-profile" aria-selected="false">Servicios y Articulos</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="pills-clientes-tab" data-toggle="pill" href="#pills-clientes" role="tab" aria-controls="pills-contact" aria-selected="false">+ Clientes</a>
        </li>
    </ul>

</div>




    <form action="{{ route("comprasarticulos.store") }}" method="POST" id="VentaServicios">
        @csrf
        <div class="tab-content" id="pills-tabContent">
            <div class="tab-pane fade show active" id="pills-general" role="tabpanel" aria-labelledby="pills-general-tab">

                <div class="form-group col-md-6">
                    <label for="NombreCliente">Seleccione Cliente<span class="text-danger">*</span></label>
                    <input type="search" name="NombreCliente" class="form-control typeahead" placeholder="Cliente" autocomplete="off" id="buscarCliente1">
                    <input type="hidden" name="IdCliente" />
                    <small id="IdClienteHelp" class="form-text text-muted">Puede incorporar mas clientes en la pestaña "Clientes".</small>
                </div>

                <div class="form-group col-md-6">
                    <label for="FechaHoraVenta">Fecha Registro<span class="text-danger">*</span></label>
                    <input type="date" name="FechaHoraVenta" id="FechaHoraVenta" class="form-control"  required  value="{{ \Carbon\Carbon::now()->format('Y-m-d')}}" readonly>
                </div>

                <div class="form-group col-md-6">
                    <label for="CodigoEstadoVenta">Estado Venta<span class="text-danger">*</span></label>
                    <input type="input" name="CodigoEstadoVenta" id="CodigoEstadoVenta" class="form-control"  required  value="INICIADO" readonly>
                </div>

                <div class="form-group col-md-6">
                    <label for="IdPromocion">Promocion</label>
                    <select id="IdPromocion" class="form-control">
                        <option selected>Seleccione...</option>
                        @foreach($promociones as $promocion)
                            <option value="{{$promocion->IdPromocion}} "> {{$promocion->NombrePromocion}} </option>
                        @endforeach
                    </select>

                </div>

                <div class="form-group col-md-6">
                    <label for="NroPersonas">Número de Personas</label>
                    <input type="text" class="form-control" id="NroPersonas" placeholder="Nro">
                </div>

                <div class="form-group col-md-6">
                    <label for="NroCasillero">Número de Casillero<span class="text-danger">*</span></label>
                    <input type="text" class="form-control" id="NroCasillero" placeholder="Casillero">
                </div>

                <div class="form-group">
                    <label for="Observaciones">Observaciones</label>
                    <textarea class="form-control" id="Observaciones" rows="2" name="Observaciones" cols="100"></textarea>
                </div>

            </div>
            <div class="tab-pane fade" id="pills-servicios" role="tabpanel" aria-labelledby="pills-servicios-tab">



                    <div class="card card-info border-primary">
                        <div class="card-header"><h6> Detalle de Servicios </h6></div>
                        <div class="card-block">

                            <div class="row mt-3 ml-1 mr-1">
                                <div class="col-lg-2"></div>
                                <div class="form-group col-lg-8 ">
                                    <input type="search" id="buscarServicio" name="servicio" class="form-control typeahead" placeholder="Servicio" autocomplete="off">
                                </div>
                            </div>




                            <div class="row mt-3 ml-1">
                                <div class="col-md-12">
                                    <table class="table table-bordered table-hover" id="tabla_servicios">
                                        <thead>
                                        <tr>
                                            <th class="text-center"> Nro</th>
                                            <th class="text-center"> Servicio</th>
                                            <th class="text-center"> Cantidad</th>
                                            <th class="text-center"> Precio</th>
                                            <th class="text-center"> Total</th>
                                            <th class="text-center" style="border-top: 1px solid #f8f9fc; border-right: 1px solid #f8f9fc; border-bottom: 1px solid #f8f9fc;"></th>
                                            <th class="text-center" style='display:none'></th>
                                        </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>


                <div class="row">

                </div>
                <div class="card card-info mt-3 border-primary">
                    <div class="card-header"><h6> Detalle de Consumo en Articulos </h6></div>
                    <div class="card-block">

                        <div class="row mt-3 ml-1 mr-1">
                            <div class="col-lg-2"></div>
                            <div class="form-group col-lg-8 ">
                                <input type="search" id="buscarArticulo" name="articulo" class="form-control typeahead" placeholder="Int. Articulo" autocomplete="off">
                            </div>
                        </div>
                        <div class="row  mt-3 ml-1">
                            <div class="col-md-12">
                                <table class="table table-bordered table-hover" id="tabla_articulos">
                                    <thead>
                                    <tr>
                                        <th class="text-center"> Nro</th>
                                        <th class="text-center"> Articulo</th>
                                        <th class="text-center"> Cantidad</th>
                                        <th class="text-center"> Precio</th>
                                        <th class="text-center"> Total</th>
                                        <th class="text-center" style="border-top: 1px solid #f8f9fc; border-right: 1px solid #f8f9fc; border-bottom: 1px solid #f8f9fc;"></th>
                                        <th class="text-center" style='display:none'></th>
                                    </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </div>
                        </div>

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
                                <th class="text-center">% Impuesto</th>
                                <td class="text-center">
                                    <div class="input-group mb-2 mb-sm-0">
                                        <input type="number" class="form-control" id="tax" placeholder="0">
                                        <div class="input-group-addon">%</div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th class="text-center">Monto Impuesto</th>
                                <td class="text-center"><input type="number" name='tax_amount' id="tax_amount"
                                                               placeholder='0.00' class="form-control" readonly/></td>
                            </tr>
                            <tr>
                                <th class="text-center">Total:</th>
                                <td class="text-center"><input type="number" name='total_amount' id="total_amount"
                                                               placeholder='0.00' class="form-control" readonly/></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group">
                        <label for="Observaciones">Observaciones</label>
                        <textarea class="form-control" id="Observaciones" rows="2" name="Observaciones" cols="100"></textarea>
                    </div>
                </div>

            </div>
            <div class="tab-pane fade" id="pills-clientes" role="tabpanel" aria-labelledby="pills-clientes-tab">
                <div class="row mt-3 ml-1 mr-1">
                    <div class="col-lg-2"></div>
                    <div class="form-group col-lg-8 ">
                        <input type="search" id="buscarCliente2" name="q" class="form-control typeahead" placeholder="Clientes" autocomplete="off">
                    </div>
                </div>




                <div class="row mt-3 ml-1">
                    <div class="col-md-12">
                        <table class="table table-bordered table-hover" id="tabla_clientes">
                            <thead>
                            <tr>
                                <th class="text-center"> Nro</th>
                                <th class="text-center"> Cliente</th>
                                <th class="text-center"> Nro Visitas</th>
                                <th class="text-center" style="border-top: 1px solid #f8f9fc; border-right: 1px solid #f8f9fc; border-bottom: 1px solid #f8f9fc;"></th>
                                <th class="text-center" style='display:none'></th>
                            </tr>
                            </thead>
                            <tbody>

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


