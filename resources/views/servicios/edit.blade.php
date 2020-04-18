@extends('welcome')
@section('content')


    <div class="container">
        <div class="card">

            <div class="col-sm-12">
                <h5 class="card-title">Los Campos con <span class="text-danger">*</span> son Obligatorios!</h5>
                <form action="{{route("servicios.update", $servicio->IdServicio)}}" method="POST">
                    @csrf
                    @method('put')
                    <div class="form-row col-md-12">
                        <div class="form-group col-md-12">
                            <label for="NombreServicio">Nombre del Servicio<span class="text-danger">*</span></label>
                            <input type="text" name="NombreServicio" id="NombreServicio" class="form-control" placeholder="Nombre del Servicio" required  value="{{$servicio->NombreServicio}}">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="Descripcion">Descripcion<span class="text-danger">*</span></label>
                            <input type="text" name="Descripcion" id="Descripcion" class="form-control" placeholder="Descripcion" required  value="{{$servicio->Descripcion}}">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="CostoServicio">Costo  del Servicio<span class="text-danger">*</span></label>
                            <input type="text" name="CostoServicio" id="CostoServicio" class="form-control" placeholder="Costo  del Servicio" required  value="{{$servicio->CostoServicio}}">
                        </div>

                        <div class="form-group">
                            <button type="submit" name="submit" value="submit" id="submit" class="btn btn-primary"><i class="fa fa-fw fa-plus-circle"></i> Actualizar Servicio</button>
                        </div>
                    </div>
                </form>

            </div>
        </div>

    </div>



@endsection
