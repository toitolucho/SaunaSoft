@extends('welcome')
@section('content')


    <div class="container">
        <div class="card">

            <div class="col-sm-12">
                <h5 class="card-title">Los Campos con <span class="text-danger">*</span> son Obligatorios!</h5>
                <form action="{{route("proveedores.update", $proveedor->IdProveedor)}}" method="POST">
                    @csrf
                    @method('put')
                    <div class="form-row">
                        <div class="form-group col-md-5">
                            <label for="NombreRazonSocial">Nombre Proveedor<span class="text-danger">*</span></label>
                            <input type="text" name="NombreRazonSocial" id="NombreRazonSocial" class="form-control" placeholder="Nombre del Proveedor" required  value="{{$proveedor->NombreRazonSocial}}">
                        </div>
                        <div class="form-group col-md-5">
                            <label for="NombreRepresentante">Representante<span class="text-danger">*</span></label>
                            <input type="text" name="NombreRepresentante" id="NombreRepresentante" class="form-control" placeholder="Representante" required  value="{{$proveedor->NombreRepresentante}}">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-5">
                            <label for="Direccion">Direccion</label>
                            <input type="text" name="Direccion" id="Direccion" class="form-control" placeholder="Direccion"   value="{{$proveedor->Direccion}}">
                        </div>
                        <div class="form-group col-md-5">
                            <label for="NroCelular">Teléfono</label>
                            <input type="number" name="NroCelular" id="NroCelular" class="form-control" placeholder="NroCelular"   value="{{$proveedor->NroCelular}}">
                        </div>
                    </div>


                    <div class="form-group">
                        <button type="submit" name="submit" value="submit" id="submit" class="btn btn-primary"><i class="fa fa-fw fa-plus-circle"></i> Actualizar Proveedor</button>
                    </div>
{{--                    </div>--}}
                </form>

            </div>
        </div>

    </div>



@endsection
