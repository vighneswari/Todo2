package com.test;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.jdo.Query;
//import javax.servlet.ServletRequest;
import javax.jdo.PersistenceManager;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Servlet extends HttpServlet {

private static final long serialVersionUID = 1L;
@SuppressWarnings("all")
public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {


String note=req.getParameter("newTodo");
ToStoreNote store=new ToStoreNote();
store.setnote(note);
PersistenceManager pm=PMF.get().getPersistenceManager();

ArrayList em=new ArrayList();
String queryStr = "SELECT FROM " + ToStoreNote.class.getName();
Query q = pm.newQuery(queryStr);
List<ToStoreNote> ToStoreNotes = (List<ToStoreNote>) q.execute();

for (ToStoreNote e : ToStoreNotes) {
String user_note = e.getnote();
em.add(user_note);
req.setAttribute("note", em);
System.out.println(em);
}
try
{
pm.makePersistent(store);
}
finally
{
pm.close();
req.getRequestDispatcher("login.jsp").include(req,resp);
}
}
}
