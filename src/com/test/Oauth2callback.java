package com.test;
import java.util.*;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;
import java.io.*;
import java.net.*;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.test.AddJdo;
import com.test.PMF;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class Oauth2callback {

//	@RequestMapping(value = "/logout")
//	public void logoutUser(HttpServletRequest req, HttpServletResponse resp)
//			throws IOException {
//		resp.sendRedirect("new.html");
//	}

	@RequestMapping(value = "/get", method = RequestMethod.GET)
	public ModelAndView hello(@RequestParam("code") String authcode,
			HttpServletRequest req, HttpServletResponse resp)
			throws IOException, ParseException, ServletException {

		String param1 = "value1";
		String param2 = "value2";
		System.out.println(authcode);
		String query = String.format("param1=%s&param2=%s",
				URLEncoder.encode(param1, "UTF-8"),
				URLEncoder.encode(param2, "UTF-8"));
		String grant_type = "authorization_code";
		String clientId = "643071805966-n4jfq2ssfv4sj3k8mhd44ninkvqr9fie.apps.googleusercontent.com";
		String clientSecret = "0ljcDRRUIpANgQXJUnh1NjPH";
		String redirect_url = "https://1-dot-todo-vijju.appspot.com/get";
//		String redirect_url = "http://localhost:8888/get";

//		String redirect_url = "http://1-dot-vighneswari-1162.appspot.com/get";

		// String redirect_url =
		// "http://www.velu-1090.appspot.com/oauth2callback";
		URLConnection connection = new URL(
				"https://www.googleapis.com/oauth2/v3/token?client_id="
						+ clientId + "&client_secret=" + clientSecret
						+ "&redirect_uri=" + redirect_url + "&grant_type="
						+ grant_type + "&code=" + authcode).openConnection();
		connection.setDoOutput(true); // Triggers POST.
		// connection.setRequestProperty("Accept-Charset", "UTF-8");
		connection.setRequestProperty("Content-Type",
				"application/x-www-form-urlencoded;charset=");
		String charset = "UTF-8";
		try (OutputStream output = connection.getOutputStream()) {
			output.write(query.getBytes(charset));
		}

		InputStream response = connection.getInputStream();
		System.out.println(response);
		StringBuilder str = new StringBuilder();

		for (int c1 = response.read(); c1 != -1; c1 = response.read()) {
			char j = (char) c1;
			str.append((char) j);
			System.out.println(str);
		}
		System.out.println(str);
		String s = new String(str);
		JSONObject json = (JSONObject) new JSONParser().parse(s);
		String access_token = json.get("access_token").toString();
		System.out.println(json.get("access_token"));

		response.close();

		// for get user info
		URLConnection conn = new URL(
				"https://www.googleapis.com/oauth2/v3/userinfo?access_token="
						+ access_token).openConnection();
		conn.setDoOutput(true); // Triggers POST.
		// connection.setRequestProperty("Accept-Charset", "UTF-8");
		conn.setRequestProperty("Content-Type",
				"application/x-www-form-urlencoded;charset=");

		try (OutputStream output1 = conn.getOutputStream()) {
			output1.write(query.getBytes(charset));
		}
		StringBuilder str1 = new StringBuilder();
		InputStream res = conn.getInputStream();
		for (int c = res.read(); c != -1; c = res.read()) {
			char j = (char) c;
			str1.append((char) j);

		}
		String userInfo = new String(str1);
		System.out.println(str1);

		
		
		
		
		JSONObject j = (JSONObject) new JSONParser().parse(userInfo);
		String userName = (String) j.get("name");
		String email = (String) j.get("email");
		String pic = (String) j.get("picture");
		
		
		HttpSession session = req.getSession();
		session.setAttribute("email", email);
		req.setAttribute("picture", pic);
		req.setAttribute("username", userName);
		req.setAttribute("email", email);
		RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
		rd.forward(req, resp);

		return null;
	}
	
	@RequestMapping(value = { "/yourTodo" })
	public ModelAndView yourTodo() {
		ModelAndView mav = new ModelAndView("yourTodo");
		return mav;
}
	@RequestMapping(value = { "/update" }, method = RequestMethod.POST)
	public @ResponseBody String update(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		PersistenceManager pm = PMF.get().getPersistenceManager();

		String status = request.getParameter("status");
		String key = request.getParameter("key");
		System.out.println(status);
		System.out.println(key);
		Query q = pm.newQuery(AddJdo.class);
		q.setFilter("key == lastNameParam");
		q.declareParameters("String lastNameParam");
		try {
			@SuppressWarnings("unchecked")
			List<AddJdo> results = (List<AddJdo>) q.execute(key);
			for (AddJdo obj : results) {
				obj.setStatus(status);
				pm.makePersistent(obj);
			}
		} catch (Exception e) {

		}
		return "success";
	}

	@RequestMapping(value = { "/delTodo" }, method = RequestMethod.POST)
	public @ResponseBody String delTodo(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		PersistenceManager pm = PMF.get().getPersistenceManager();

		String delElement = request.getParameter("delElement");
		System.out.println("DeleteElement from front end" + delElement);

		Query q = pm.newQuery(AddJdo.class);
		q.setFilter("key == lastNameParam");
		q.declareParameters("String lastNameParam");

		try {
			@SuppressWarnings("unchecked")
			List<AddJdo> results = (List<AddJdo>) q.execute(delElement);
			pm.deletePersistentAll(results);
			// pm.deletePersistent(results);
		} finally {
			q.closeAll();
		}

		return "success";

	}

	@RequestMapping(value = { "/addJdo" }, method = RequestMethod.POST)
	public @ResponseBody String addJdo(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		HttpSession session = request.getSession();
		response.setContentType("text/html");
		String email = (String) session.getAttribute("email");
		System.out.println(email);
		Query q = pm.newQuery(AddJdo.class);
		q.setFilter("email == '" + email + "'");
		@SuppressWarnings("unchecked")
		List<AddJdo> results = (List<AddJdo>) q.execute();
		Gson gson = new Gson();

		// sort testing
		HashSet<List> hset=new HashSet<List>();  
        hset.add(results);	
        results.clear();
        results.addAll(results);
    
         System.out.println("checking hashset" +results);	
         // end sort testin
		return gson.toJson(results);

	}

	@RequestMapping(value = { "/logout" })
	public void logout(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		HttpSession session = request.getSession(false);
		session.invalidate();
		response.sendRedirect("/new.html");
	}

	@RequestMapping(value = { "/addTodo" }, method = RequestMethod.POST)
	public void addTodo(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		PersistenceManager pm = PMF.get().getPersistenceManager();
		// HttpSession session = request.getSession();
		response.setContentType("text/html");
		String todoArray = request.getParameter("todoArray");
		PrintWriter out = response.getWriter();
		System.out.println(todoArray);

		Gson gson = new Gson();
		AddJdo target2 = gson.fromJson(todoArray, AddJdo.class);
		System.out.println(target2);
		// target2.setStatus("active");
		pm.makePersistent(target2);
		System.out.println("persisted");
		out.print("success");
	}

}