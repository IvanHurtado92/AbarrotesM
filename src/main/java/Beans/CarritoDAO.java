package Beans;
import Hibernate.HibernateUtil;
import Mapeos.Carrito;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class CarritoDAO {
    private Session sesion;
    private Transaction tx;

    public int guardarCarrito(Carrito carrito) throws HibernateException {
        int id = -1;
        try {
            iniciaOperacion();
            id = (Integer) sesion.save(carrito);
            tx.commit();
        } catch (HibernateException he) {
            manejaExcepcion(he);
            throw he;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        } finally {
            sesion.close();
        }
        return id;
    }

    public void eliminaCarrito(int ID_Carrito) throws HibernateException {
        try {
            iniciaOperacion();
            Carrito carrito = (Carrito) sesion.get(Carrito.class, ID_Carrito);
            sesion.delete(carrito);
            tx.commit();
        } catch (HibernateException he) {
            manejaExcepcion(he);
        } finally {
            sesion.close();
        }
    }

    public Carrito obtenCarrito(int ID_Carrito) throws HibernateException {
        Carrito carrito = null;
        try {
            iniciaOperacion();
            carrito = (Carrito) sesion.get(Carrito.class, ID_Carrito);
        } finally {
            sesion.close();
        }
        return carrito;
    }

    public List<Carrito> obtenListaCarrito() throws HibernateException {
        List<Carrito> listaCarritos = null;

        try {
            iniciaOperacion();
            listaCarritos = sesion.createQuery("from Carrito").list();
        } finally {
            sesion.close();
        }
        return listaCarritos;
    }

    public List<Carrito> obtenCarritoPorCliente(int idCliente) throws HibernateException {
        List<Carrito> listaCarritos = null;
        try {
            iniciaOperacion();
            listaCarritos = sesion.createQuery("from Carrito where idCliente = :idCliente", Carrito.class)
                    .setParameter("idCliente", idCliente)
                    .getResultList();
        } catch (HibernateException he) {
            manejaExcepcion(he);
            throw he;
        } finally {
            sesion.close();
        }
        return listaCarritos;
    }

    public int actualizaCarrito(Carrito carrito) throws HibernateException {
        try {
            iniciaOperacion();
            sesion.update(carrito);
            tx.commit();
        } catch (HibernateException he) {
            manejaExcepcion(he);
            throw he;
        } finally {
            sesion.close();
        }
        return 0;
    }

    /* forma de actualizar 2 */
//    public void updateEmpleado(Integer NoEmpleado, String NombreEmpleado) {
//        iniciaOperacion();
//        try {
//            Empleado empleado =
//                    (Empleado) sesion.get(Empleado.class, NoEmpleado);
//            Empleado.setFirstName(nombre);
//            sesion.update(empleado);
//            tx.commit();
//        } catch (HibernateException he) {
//            manejaExcepcion(he);
//        } finally {
//            sesion.close();
//        }
//    }

    private void iniciaOperacion(){
        try{
            sesion = HibernateUtil.getSessionFactory().openSession();
            tx = sesion.beginTransaction();
        }catch(Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }

    private void manejaExcepcion(HibernateException he) throws HibernateException {
        tx.rollback();
        throw new HibernateException("Ocurrió un error en la capa de acceso a datos", he);
    }

}
