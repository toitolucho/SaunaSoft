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
<script type="text/javascript">

        $(document).ready(function(){
           // var i= {{count($compra->comprasarticulosdetalles)}};
            var i =  {!! count($compra->comprasarticulosdetalles) !!};
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
            console.log(engine);

            $(".typeahead").typeahead({
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
                        console.log("datos del servidor : ");
                        console.log(data);
                        //return '<a href="' + data.NombreArticulo + '" class="list-group-item">' + data.NombreArticulo + ' - @' + data.NombreArticulo + '</a>'
                        return ('<div class="list-group-item" >' + data.NombreArticulo + '</div>');
                        // return  data.NombreArticulo;
                    }
                }
            }).on('typeahead:selected', function(event, data) {
                console.log("seleccionado");
                console.log(data.NombreArticulo);
                //$('.search-inputs').val(data.NombreArticulo);

                var name = data.NombreArticulo;
                var codigo = data.NombreArticulo;
                var precio = data.PrecioVigente;
                var markup = "<tr id=addr" +(i+1)+">" +
                    "<td>" +(i+1)+" </td>"+
                    "<td><input type='text' name='productos[]' class='form-control' value ='"+ name+"'  readonly/></td>" +
                    "<td><input type='number' name='cantidades[]' class='form-control qty' step='1' value ='1' ></td>" +
                    "<td><input type='number' name='precios[]' placeholder='Int. Precio Unitario' class='form-control price' step='0.00' min='0' value='"+precio +"'> </td>" +
                    "<td><input type='number' name='total[]' placeholder='0.00' class='form-control total'  value='"+precio +"' readonly/></td>"+
                    "<td data-name='del" +(i+1)+"'><button onclick='removeRow("+(i+1)+");' name='del" +(i+1)+"' class='btn btn-danger glyphicon glyphicon-remove row-remove'><span aria-hidden='true'>×</span></button></td>"+
                    "<td style='display:none'> <input name='codigos[]' value='"+data.IdArticulo +"''> </td>"+

                "</tr>";
                $('#tab_logic').append(markup);
                calc_total();


                i++;




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


    </script>




    <div class="row clearfix">




            <div class="form-group col-sm-10">
                <input type="search" name="q" class="form-control typeahead" placeholder="Int. Articulo" autocomplete="off">
            </div>

    </div>




    <form action="/comprasarticulos/{{$compra->IdCompraArticulo}}" method="POST">
        @csrf
        @method('put')


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
                        <th class="text-center" style="border-top: 1px solid #f8f9fc; border-right: 1px solid #f8f9fc; border-bottom: 1px solid #f8f9fc;">
                        </th>
                        <th class="text-center" style='display:none'>
                        </th>
                    </tr>
                    </thead>
                    <tbody>

                        @foreach($compra->comprasarticulosdetalles as $detalle)
                                        <tr id= "addr{{$loop->index+1}}">
                                            <td>{{$loop->index+1}}</td>
                                            <td><input type='text' name='productos[]' class='form-control' value ="{{$detalle->articulo->NombreArticulo}}"  readonly/></td>
                                            <td><input type='number' name='cantidades[]' class='form-control qty' step='1' value ="{{$detalle->Cantidad}}" ></td>
                                            <td><input type='number' name='precios[]' placeholder='Int. Precio Unitario' class='form-control price' step='0.00' min='0' value="{{$detalle->Precio}}"> </td>
                                            <td><input type='number' name='total[]' placeholder='0.00' class='form-control total'  value="{{ $detalle->Cantidad*$detalle->Precio }}" readonly/></td>
                                            <td data-name='del{{$loop->index+1}}'><button onclick='removeRow({{$loop->index+1}});' name='del{{$loop->index+1}}' class='btn btn-danger glyphicon glyphicon-remove row-remove'><span aria-hidden='true'>×</span></button></td>
                                            <td style='display:none'> <input name='codigos[]' value="{{$detalle->IdCompraArticulo}}"> </td>
                                        </tr>


                        @endforeach

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
                        <td class="text-center"><input type="number" name='sub_total' placeholder='0.00' value ="{{$total}}"
                                                       class="form-control" id="sub_total"    readonly> </td>
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
                        <td class="text-center"><input type="number" name='total_amount' id="total_amount" value ="{{$total}}"
                                                       placeholder='0.00' class="form-control" readonly/></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="row">
            <div class="form-group">
                <label for="Observaciones">Observaciones</label>
                <textarea class="form-control" id="Observaciones" rows="2" name="Observaciones" cols="100" >{{$compra->Observaciones}}</textarea>
            </div>
        </div>
        <div class="row">
            <input class="ml-auto btn btn-danger" type="submit" value="Guardar">
        </div>
    </form>

@endsection


