@extends('welcome')
@section('content')

{{--    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-typeahead/2.11.0/jquery.typeahead.js"></script>--}}

{{--    <script src="https://cdnjs.cloudflare.com/ajax/libs/corejs-typeahead/1.3.0/bloodhound.min.js"></script>--}}

<style>
    #scrollable-dropdown-menu .tt-dropdown-menu {
        max-height: 150px;
        overflow-y: auto;
    }
</style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/corejs-typeahead/1.3.0/typeahead.bundle.min.js"></script>
<script type="text/javascript">

        $(document).ready(function(){
            var i=1;
            $("#add_row").click(function(){
                b=i-1;
                $('#addr'+i).html($('#addr'+b).html()).find('td:first-child').html(i+1);
                $('#tab_logic').append('<tr id="addr'+(i+1)+'"></tr>');
                i++;
            });
            $("#delete_row").click(function(){
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


        });

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




        jQuery(document).ready(function($) {

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
                $('.search-inputs').val(data.NombreArticulo);
            });


        });


    </script>



    {{-- ... customer name and email fields --}}

    <div class="container">



{{--        <form class="typeahead" role="search">--}}
{{--            <div class="form-group col-sm-10">--}}
{{--                <input type="search" name="q" class="form-control search-inputs" placeholder="Int. Articulo" autocomplete="off">--}}
{{--            </div>--}}
            <div id="scrollable-dropdown-menu" class="my-lg-4">

                <input type="search" class="form-control typeahead" type="text" placeholder="Articulos" autocomplete="off">
            </div>
{{--        </form>--}}

        </div>

        <div class="row clearfix">
            <div class="col-md-12">
                <table class="table table-bordered table-hover" id="tab_logic">
                    <thead>
                    <tr>
                        <th class="text-center"> #</th>
                        <th class="text-center"> Articulo</th>
                        <th class="text-center"> Cantidad</th>
                        <th class="text-center"> Precio</th>
                        <th class="text-center"> Total</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr id='addr0'>
                        <td>1</td>
                        <td>


{{--                            <input type="text" name='product[]' placeholder='Int. Articulo' class="typeahead form-control"/>--}}

                            <input class="typeahead form-control" type="text" name='product[]'>
                        </td>
                        <td><input type="number" name='qty[]' placeholder='Int. Cantidad' class="form-control qty" step="0" value ="1"
                                   min="0"/></td>
                        <td><input type="number" name='price[]' placeholder='Int. Precio Unitario'
                                   class="form-control price" step="0.00" min="0"/></td>
                        <td><input type="number" name='total[]' placeholder='0.00' class="form-control total" readonly/>
                        </td>
                    </tr>
                    <tr id='addr1'></tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="row clearfix">
            <div class="col-md-12">
                <button id="add_row" class="btn btn-default pull-left">Add Row</button>
                <button id='delete_row' class="pull-right btn btn-default">Delete Row</button>
            </div>
        </div>
        <div class="row clearfix" style="margin-top:20px">
            <div class="pull-right col-md-4">
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




    <form action="{{ route("comprasarticulos.store") }}" method="POST">
        @csrf

        <div class="card">
            <div class="card-header">
                Articulos
            </div>

            <div class="card-body">
                <table class="table" id="products_table">
                    <thead>
                    <tr>
                        <th>Articulo</th>
                        <th>Cantidad</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr id="product0">
                        <td>
                            <select name="products[]" class="form-control">
                                <option value="">-- choose product --</option>
                                @foreach ($articulos as $articulo)
                                    <option value="{{ $articulo->IdArticulo }}">
                                        {{ $articulo->NombreArticulo }} (${{ number_format($articulo->PrecioVigente, 2) }})
                                    </option>
                                @endforeach
                            </select>
                        </td>
                        <td>
                            <input type="number" name="quantities[]" class="form-control" value="1" />
                        </td>
                    </tr>
                    <tr id="product1"></tr>
                    </tbody>
                </table>

                <div class="row">
                    <div class="col-md-12">
                        <button id="add_row" class="btn btn-default pull-left">+ Add Row</button>
                        <button id='delete_row' class="pull-right btn btn-danger">- Delete Row</button>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <input class="btn btn-danger" type="submit" value="{{ trans('global.save') }}">
        </div>
    </form>



@endsection

