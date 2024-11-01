package Beans;

import Hibernate.HibernateUtil;
import Mapeos.CarritoAct;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class CarritoActDAO {
    private Session sesion;
    private Transaction tx;

    public int guardarCarritoAct(CarritoAct carritoAct) throws HibernateException {
        int id = -1;
        try {
            iniciaOperacion();
            id = (Integer) sesion.save(carritoAct);
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

    public void eliminaCarritoAct(int ID_CarritoAct) throws HibernateException {
        try {
            iniciaOperacion();
            CarritoAct carritoAct = (CarritoAct) sesion.get(CarritoAct.class, ID_CarritoAct);
            sesion.delete(carritoAct);
            tx.commit();
        } catch (HibernateException he) {
            manejaExcepcion(he);
        } finally {
            sesion.close();
        }
    }

    public CarritoAct obtenCarritoAct(int ID_CarritoAct) throws HibernateException {
        CarritoAct carritoAct = null;
        try {
            iniciaOperacion();
            carritoAct = (CarritoAct) sesion.get(CarritoAct.class, ID_CarritoAct);
        } finally {
            sesion.close();
        }
        return carritoAct;
    }

    public List<CarritoAct> obtenListaCarrito() throws HibernateException {
        List<CarritoAct> listaCarritosAct = null;

        try {
            iniciaOperacion();
            listaCarritosAct = sesion.createQuery("from CarritoAct").list();
        } finally {
            sesion.close();
        }
        return listaCarritosAct;
    }

    public List<CarritoAct> obtenCarritoPorCliente(int idCliente) throws HibernateException {
        List<CarritoAct> listaCarritosAct = null;
        try {
            iniciaOperacion();
            listaCarritosAct = sesion.createQuery("from CarritoAct where idCliente = :idCliente", CarritoAct.class)
                    .setParameter("idCliente", idCliente)
                    .getResultList();
        } catch (HibernateException he) {
            manejaExcepcion(he);
            throw he;
        } finally {
            sesion.close();
        }
        return listaCarritosAct;
    }

    public List<CarritoAct> obtenCarritoPorGrupo(int grupoCarrito, int idCliente) throws HibernateException {
        List<CarritoAct> listaCarritosAct = null;
        try {
            iniciaOperacion();
            listaCarritosAct = sesion.createQuery("from CarritoAct where grupoCarrito = :grupoCarrito and idCliente = :idCliente", CarritoAct.class)
                    .setParameter("grupoCarrito", grupoCarrito)
                    .setParameter("idCliente", idCliente)
                    .getResultList();
        } catch (HibernateException he) {
            manejaExcepcion(he);
            throw he;
        } finally {
            sesion.close();
        }
        return listaCarritosAct;
    }

    public int actualizaCarrito(CarritoAct carritoAct) throws HibernateException {
        try {
            iniciaOperacion();
            sesion.update(carritoAct);
            tx.commit();
        } catch (HibernateException he) {
            manejaExcepcion(he);
            throw he;
        } finally {
            sesion.close();
        }
        return 0;
    }

    public void borrarTabla() throws HibernateException {
        try {
            iniciaOperacion();
            sesion.createQuery("delete from CarritoAct").executeUpdate();
            tx.commit();
        } catch (HibernateException he) {
            manejaExcepcion(he);
            throw he;
        }
        finally {
            sesion.close();
        }
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
