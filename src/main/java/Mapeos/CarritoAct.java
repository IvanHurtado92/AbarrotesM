package Mapeos;

public class CarritoAct implements java.io.Serializable {

    private Integer idCarrito;
    private Integer grupoCarrito;
    private Integer idCliente;
    private Integer idProducto;
    private Integer cantidad;
    private Float precio;

    public CarritoAct() {}

    public CarritoAct(Integer grupoCarrito, Integer idCliente, Integer idProducto, Integer cantidad) {
        this.grupoCarrito = grupoCarrito;
        this.idCliente = idCliente;
        this.idProducto = idProducto;
        this.cantidad = cantidad;
    }

    public Integer getGrupoCarrito(){return grupoCarrito;}
    public void setGrupoCarrito(Integer grupoCarrito){this.grupoCarrito = grupoCarrito;}
    public Integer getIdCarrito() {
        return idCarrito;
    }
    public void setIdCarrito(Integer idCarrito) {
        this.idCarrito = idCarrito;
    }
    public Integer getIdCliente() {
        return idCliente;
    }
    public void setIdCliente(Integer idCliente) {
        this.idCliente = idCliente;
    }
    public Integer getIdProducto() {
        return idProducto;
    }
    public void setIdProducto(Integer idProducto) {
        this.idProducto = idProducto;
    }
    public Integer getCantidad() {
        return cantidad;
    }
    public void setCantidad(Integer cantidad) {
        this.cantidad = cantidad;
    }
    public Float getPrecio() {
        return precio;
    }
    public void setPrecio(Float precio) {
        this.precio = precio;
    }
}
