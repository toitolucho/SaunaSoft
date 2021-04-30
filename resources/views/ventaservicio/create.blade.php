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
    window.promociones = {!! json_encode($promociones) !!};


    var formularioValido = true;
    (function() {
        'use strict';
        window.addEventListener('load', function() {
            // Fetch all the forms we want to apply custom Bootstrap validation styles to
            var forms = document.getElementsByClassName('needs-validation');
            // Loop over them and prevent submission
            var validation = Array.prototype.filter.call(forms, function(form) {
                form.addEventListener('submit', function(event) {
                    if (form.checkValidity() === false) {
                        event.preventDefault();
                        event.stopPropagation();
                        formularioValido = false;
                        bootbox.alert("Porfavor revise lo datos a ingresar, le falta llenar algunos campos");

                    }
                    form.classList.add('was-validated');
                }, false);
            });
        }, false);
    })();

        $(document).ready(function(){
            var NroArticulos=0;
            var NroServicios = 0;
            var NroClientes = 0;



           // $("#tabs").tabs();

            $('#tabla_servicios tbody').on('keyup change',function(){
                calc();
            });
            $('#tax').on('keyup change',function(){
                calc_total();
            });

            $('#tabla_articulos tbody').on('keyup change',function(){
                calc();
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
                var cantidadExistencia = data.CantidadExistencia;


                dato = existeTupla('tabla_articulos', data.IdArticulo, 7);
                if(dato == true)
                {
                    bootbox.alert("El articulo <strong> \"" + name + "\" </strong>ya se encuentra en el detalle");
                    return;
                }
                var markup = "<tr id=articulo" +(NroArticulos+1)+">" +
                    "<td class='w-5  '>" +(NroArticulos+1)+" </td>"+
                    "<td class='w-50 '><input type='text' name='productos[]' class='form-control' value ='"+ name+"'  readonly/></td>" +
                    "<td class='w-10 text-right'><input type='number' name='cantidades[]' class='form-control qty' step='1' value ='1'  data-existencia ='"+ cantidadExistencia+ "' min='1' ></td>" +
                    "<td class='w-15 text-right'><input type='number' name='precios[]' placeholder='Int. Precio Unitario' class='form-control price' step='0.00' min='0' value='"+precio +"' min='0'> </td>" +
                    "<td class='w-15 text-right'><input type='number' name='total[]' placeholder='0.00' class='form-control total'  value='"+precio +"' min='0' readonly/></td>"+
                    "<td class='w-5  text-center' data-name='del" +(NroArticulos+1)+"'><button onclick='removeRowArticulo("+(NroArticulos+1)+");' name='articulo" +(NroArticulos+1)+"' class='btn btn-danger glyphicon glyphicon-remove row-remove'><span aria-hidden='true'>×</span></button></td>"+
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



            $("#validationbuscarCliente1").typeahead({
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

                dato = existeTupla('tabla_clientes', IdCliente, 5);
                if(dato == true)
                {
                    bootbox.alert("El cliente <strong> \"" + nombreCompleto + "\" </strong>ya se encuentra en la lista");
                    return;
                }


                var markup = "<tr id=cliente" +(NroClientes+1)+">" +
                    "<td class='w-5' >" +(NroClientes+1)+" </td>"+
                    "<td class='w-70'>" +nombreCompleto+" </td>"+
                    "<td class='w-20 text-right'>" +NroVisitas+" </td>"+
                    "<td class='w-5 text-center' data-name='del" +(NroClientes+1)+"'><button onclick='removeRowCliente("+(NroClientes+1)+");' name='delcliente" +(NroClientes+1)+"' class='btn btn-danger glyphicon glyphicon-remove row-remove'><span aria-hidden='true'>×</span></button></td>"+
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

                dato = existeTupla('tabla_servicios', IdServicio, 11);
                if(dato == true)
                {
                    bootbox.alert("El servicio <strong> \"" + NombreServicio + "\" </strong>ya se encuentra en el detalle");
                    return;
                }


                var promociones = window.promociones;
                var opciones = "<option value='' selected disabled>Ninguno</option>";
                for(var k in promociones) {
                    if(promociones[k].IdServicio == IdServicio || promociones[k].IdServicio == null)
                    {
                        opciones = opciones + "<option value='" +promociones[k].IdPromocion + "' data-descuento='" + promociones[k].PorcentajeDescuento+ "'>" + promociones[k].NombrePromocion + "</option>";
                    }
                }

                var markup = "<tr id=servicio" +(NroServicios+1)+">" +
                    "<td class='w-5 '>" +(NroServicios+1)+" </td>"+
                    "<td class='w-50 '><input type='text' name='servicios[]' class='form-control' value ='"+ NombreServicio+"'  readonly/></td>" +
                    "<td class='w-10 text-right'><input type='input' name='cantidades_servicios[]' class='form-control qty' step='1' value ='1'></td>" +
                    "<td class='w-15 text-right'><input type='input' name='precios_servicios[]' placeholder='Int. Precio Unitario' class='form-control price' step='0.00' min='0' value='"+CostoServicio +"' readonly data-precio='" +CostoServicio  + "'> </td>" +
                    "<td class='w-15 text-right'><input type='input' name='total_servicios[]' placeholder='0.00' class='form-control total'  value='"+CostoServicio +"' readonly/></td>"+
                    "<td style='display:none'> <input name='codigos_promociones[]' class ='IdPromocion' value='-1'> </td>"+
                    "<td style='display:none'> <input name='descuento_promociones[]' class ='descuento' value='-1'> </td>"+
                    "<td style='display:none'> <input name='costoverdadero_promociones[]' class ='costoverdadero' value='-1'> </td>"+
                    "<td class='w-10 text-right'>" +
                        "<select name='IdPromociones[]' class='form form-control input-group-sm codigo' data-name='promo" +(NroServicios+1)+"' data-fila='"+ NroServicios+1 +"' >   "+ opciones +"   </select>"+
                    "</td>" +
                    "<td class='w-5 text-center' data-name='del" +(NroServicios+1)+"'><button onclick='removeRowServicio("+(NroServicios+1)+");' name='del" +(NroServicios+1)+"' class='btn btn-danger glyphicon glyphicon-remove row-remove'><span aria-hidden='true'>×</span></button></td>"+
                    "<td style='display:none'> <input name='codigos_servicios[]' value='"+IdServicio +"'> </td>"+


                    "</tr>";
                $('#tabla_servicios').append(markup);
                calc_total();

                NroServicios++;

            });


            // $(".codigo").change(function(e) {
            //     console.log("entra");
            //
            //     var optionSelected= $(this).find("option:selected");
            //     var valueSelected2  = optionSelected.val();
            //     var textSelected2   = optionSelected.text();
            //     console.log(valueSelected2 + " " + textSelected2);
            // });
            //
            //
            // $(".codigo").on("change", function(){
            //     alert($(this).val());});

            $(document).on('change',".codigo", function(e){
                //alert(this.value);
                    var optionSelected= $(this).find("option:selected");
                    var valueSelected2  = optionSelected.val();
                    // var textSelected2   = optionSelected.text();
                    // var datoFila = $(this).attr('data-fila');
                    // var IdPromcion = $(this).attr('data-name');

                // "<td style='display:none'> <input name='codigos_promociones[]' class ='IdPromocion' value='-1'> </td>"+
                // "<td style='display:none'> <input name='descuento_promociones[]' class ='descuento' value='-1'> </td>"+
                // "<td style='display:none'> <input name='costoverdadero_promociones[]' class ='costoverdadero' value='-1'> </td>"+

                    var descuento = $(this).find("option:selected").attr('data-descuento');
                    var precio = $(this).closest('tr').find('.price').attr('data-precio');
                    var cantidad = $(this).closest('tr').find('.qty').val();

                    var precioDescuencto = precio * descuento /100;

                    $(this).closest('tr').find('.price').val(precioDescuencto);
                    $(this).closest('tr').find('.total').val(precioDescuencto*cantidad);

                    console.log($(this).closest('tr').find('.descuento'));

                    $(this).closest('tr').find('.descuento').attr('value',descuento);
                    $(this).closest('tr').find('.costoverdadero').attr('value',precio);
                    $(this).closest('tr').find('.IdPromocion').attr('value',valueSelected2);


                    calc_total();


            });


            $('#VentaServicios').submit(function(e) {

                if(!formularioValido)
                {
                    return;
                }

                respuesta = false;
                var currentForm = this;
                e.preventDefault();
                var rowCountArticulos = $('#tabla_articulos tr').length;
                var rowCountServicios = $('#tabla_servicios tr').length;
                if(rowCountServicios < 2)
                {
                    bootbox.alert({
                        title: "Venta sin Servicios?",
                        message: "No ha registrado níngun servicio",
                        size: 'small'
                    });
                    // var index = $('#tabs a[href="#pills-servicios"]').parent().index();
                    // console.log(index);
                    // $('#tabs').tabs('select', index);


                    //$('#tabs').tabs('select', '#pills-servicios');
                    //$("#tabs").tabs("pills-servicios", "active", 2);

                    // var index = $('#tabs a[href="#pills-servicios"]').parent().index();
                    // $("#tabs").tabs("option", "active", index);

                    $('#pills-servicios-tab')[0].click();




                    return;
                }

                if(rowCountArticulos < 2)
                {


                    bootbox.confirm({
                        title: "Venta sin Articulos?",
                        message: "se eencuentra seguro de registrar la venta sin el registro de ningun articulo para la venta",
                        buttons: {
                            cancel: {
                                label: '<i class="fa fa-times"></i> Cancel'
                            },
                            confirm: {
                                label: '<i class="fa fa-check"></i> Confirm'
                            }
                        },
                        callback: function (result) {
                            //callback(result);
                            respuesta =  result;
                            console.log( "Dentro " + respuesta);

                            if(respuesta)
                                currentForm.submit();
                        }
                    });

                }
                else {
                    currentForm.submit();
                }





            });


        });

        function removeRowServicio(removeNum) {
            jQuery('#servicio'+removeNum).remove();
            calc_total();
        }

        function removeRowArticulo(removeNum) {
            jQuery('#articulo'+removeNum).remove();
            calc_total();
        }

        function removeRowCliente(removeNum) {
            jQuery('#cliente'+removeNum).remove();
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


            $('#tabla_articulos tbody tr').each(function(i, element) {
            var html = $(this).html();
            if(html!='')
            {
                var existencia = $(this).find('.qty').attr('data-existencia');
                //console.log("Existencia "+ existencia);


                var qty = $(this).find('.qty').val();
                var price = $(this).find('.price').val();

                if(parseInt(qty) > parseInt(existencia))
                {
                    alert("No puede vender esa cantidad ya que no existe esa cantidad de existencia ");
                    return;
                }
                $(this).find('.total').val(qty*price);

                calc_total();
            }
            });
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




        function existeTupla(tabla, id, nro_columna) {

            console.log("buscando dublicados");
            var table = document.getElementById(tabla);

            /*
            Extract and iterate rows from tbody of table2
            */
            for(const tr of table.querySelectorAll("tbody tr")) {

                /*
                Extract first and second cell from this row
                */
                const td0 = tr.querySelector("td:nth-child("+nro_columna+")");
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


                if(!td0 ) {
                    continue;
                }


                if ((objValue == id) ) {

                    console.log(`Match found for ${id} . Insert rejected`);
                    return true;
                }
            }
            return false;
        }


    </script>
<div class="row" id="tabs">
    <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
        <li class="nav-item">
            <a class="nav-link active" id="pills-general-tab" data-toggle="pill" href="#pills-general" role="tab" aria-controls="pills-home" aria-selected="true">General</a>
        </li>
        <li class="nav-item">
            <a  href="#pills-servicios" class="nav-link" id="pills-servicios-tab" data-toggle="pill"  role="tab" aria-controls="pills-profile" aria-selected="false">Servicios y Articulos</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="pills-clientes-tab" data-toggle="pill" href="#pills-clientes" role="tab" aria-controls="pills-contact" aria-selected="false">+ Clientes</a>
        </li>
    </ul>

</div>


    <div class="card-body">
        @if (session('validacion'))
            <div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i>
                {{ session('validacion') }}
            </div>
        @endif

        @if ($errors->any())
            <div class="alert alert-danger">
                <ul>
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </div>
        @endif
    </div>



<form action="{{ route("ventasservicios.store") }}" method="POST" id="VentaServicios"  class="needs-validation" novalidate>
    @csrf
    <div class="tab-content" id="pills-tabContent">
            <div class="tab-pane fade show active" id="pills-general" role="tabpanel" aria-labelledby="pills-general-tab">

                <div class="form-group col-md-6">
                    <label for="validationbuscarCliente1" >Seleccione Cliente<span class="text-danger" >*</span></label>
                    <input type="search" name="NombreCliente" class="form-control typeahead" placeholder="Cliente" autocomplete="off" id="validationbuscarCliente1" required value="{{old('NombreCliente')}}">
                    <div class="invalid-feedback">
                        Porfavor seleccione un cliente.
                    </div>


                    <input type="hidden" name="IdCliente"   value="{{old('IdCliente')}}" />
                    <small id="IdClienteHelp" class="form-text text-muted">Puede incorporar mas clientes en la pestaña "Clientes".</small>
                </div>

                <div class="form-group col-md-6">
                    <label for="FechaHoraVenta">Fecha Registro<span class="text-danger">*</span></label>
                    <input type="date" name="FechaHoraVenta" id="FechaHoraVenta" class="form-control"  required  value="{{ \Carbon\Carbon::now()->format('Y-m-d')}}" >
                </div>

                <div class="form-group col-md-6">
                    <label for="CodigoEstadoVenta">Estado Venta<span class="text-danger">*</span></label>
{{--                    <input type="input" name="CodigoEstadoVenta" id="CodigoEstadoVenta" class="form-control"  required  value="INICIADO" readonly>--}}
                    <select id="CodigoEstadoVenta" class="form-control" name="CodigoEstadoVenta" >
                        <option value="I" selected>INICIADO</option>
                        <option value="A">ANULADO</option>
                        <option value="F">FINALIZADO</option>

                    </select>

                </div>

{{--                <div class="form-group col-md-6">--}}
{{--                    <label for="IdPromocion">Promocion</label>--}}
{{--                    <select id="IdPromocion" class="form-control" name="IdPromocion" >--}}
{{--                        <option selected>Seleccione...</option>--}}
{{--                        @foreach($promociones as $promocion)--}}





{{--                            @if (old('IdPromocion') == $promocion->IdPromocion)--}}
{{--                                <option value="{{$promocion->IdPromocion}} " selected> {{$promocion->NombrePromocion}} </option>--}}
{{--                            @else--}}
{{--                                <option value="{{$promocion->IdPromocion}} "> {{$promocion->NombrePromocion}} </option>--}}
{{--                            @endif--}}
{{--                        @endforeach--}}
{{--                    </select>--}}

{{--                </div>--}}

{{--                <div class="form-group col-md-6">--}}
{{--                    <label for="NroPersonas">Número de Personas</label>--}}
{{--                    <input type="text" class="form-control" id="NroPersonas" placeholder="Nro" name="NroPersonas" required value="{{old('NroPersonas')}}">--}}
{{--                    <div class="invalid-feedback">--}}
{{--                        Porfavor Ingrese el numero de Personas.--}}
{{--                    </div>--}}
{{--                </div>--}}

                <div class="form-group col-md-6">
                    <label for="NroCasillero">Número de Casillero<span class="text-danger">*</span></label>
                    <input type="text" class="form-control" id="NroCasillero" placeholder="Casillero" name="NroCasillero" required value="{{old('NroCasillero')}}">
                    <div class="invalid-feedback">
                        Porfavor Ingrese el numero de Casillero.
                    </div>
                </div>

                <div class="form-group">
                    <label for="Observaciones">Observaciones</label>
                    <textarea class="form-control" id="Observaciones" rows="2" name="Observaciones" cols="100"> {{old('Observaciones')}} </textarea>
                </div>

            </div>
            <div class="tab-pane fade" id="pills-servicios" role="tabpanel" aria-labelledby="pills-servicios-tab">



                    <div class="card card-info border-dark">
                        <div class="card-header text-white bg-dark"><h6> Detalle de Servicios </h6></div>
                        <div class="card-block">

                            <div class="row mt-3 ml-1 mr-1">
                                <div class="col-lg-2"></div>
                                <div class="form-group col-lg-8 ">
                                    <input type="search" id="buscarServicio" name="servicio" class="form-control typeahead" placeholder="Servicio" autocomplete="off">
                                    <div class="invalid-feedback">
                                        Porfavor seleccione al menos un servicio.
                                    </div>
                                </div>
                            </div>




                            <div class="row mt-3 ml-1">
                                <div class="col-md-12">
                                    <table class="table table-bordered table-hover" id="tabla_servicios">
                                        <thead>
                                        <tr>
                                            <th class='w-5 text-center'  > Nro</th>
                                            <th class='w-50 text-center'  > Servicio</th>
                                            <th class='w-10 text-center'  > Cantidad</th>
                                            <th class='w-15 text-center'  > Precio</th>
                                            <th class='w-15 text-center'  > Total</th>
                                            <th class="w-5 text-center" style="border-top: 1px solid #f8f9fc; border-right: 1px solid #f8f9fc; border-bottom: 1px solid #f8f9fc;"></th>
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
                <div class="card card-info border-dark mt-3">
                    <div class="card-header text-white bg-dark"><h6> Detalle de Consumo en Articulos </h6></div>
                    <div class="card-block">

                        <div class="row mt-3 ml-1 mr-1">
                            <div class="col-lg-2"></div>
                            <div class="form-group col-lg-8 ">
                                <input type="search" id="buscarArticulo" name="articulo" class="form-control typeahead" placeholder="Int. Articulo" autocomplete="off" >

                            </div>
                        </div>
                        <div class="row  mt-3 ml-1">
                            <div class="col-md-12">
                                <table class="table table-bordered table-hover" id="tabla_articulos">
                                    <thead>
                                    <tr>
                                        <th class='w-5 text-center'> Nro</th>
                                        <th class='w-50 text-center'> Articulo</th>
                                        <th class='w-10 text-center'> Cantidad</th>
                                        <th class='w-15 text-center'> Precio</th>
                                        <th class='w-15 text-center'> Total</th>
                                        <th class='w-5 text-center' style="border-top: 1px solid #f8f9fc; border-right: 1px solid #f8f9fc; border-bottom: 1px solid #f8f9fc;"></th>
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
{{--                <div class="row">--}}
{{--                    <div class="form-group">--}}
{{--                        <label for="Observaciones">Observaciones</label>--}}
{{--                        <textarea class="form-control" id="Observaciones" rows="2" name="Observaciones" cols="100"></textarea>--}}
{{--                    </div>--}}
{{--                </div>--}}

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
                                <th  class='w-5 text-center'  > Nro</th>
                                <th  class='w-70 text-center' > Cliente</th>
                                <th  class='w-20 text-center' > Nro Visitas</th>
                                <th  class='w-5 text-center'   style="border-top: 1px solid #f8f9fc; border-right: 1px solid #f8f9fc; border-bottom: 1px solid #f8f9fc;"></th>
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


