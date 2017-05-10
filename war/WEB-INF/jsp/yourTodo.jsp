<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%-- <%@page import="com.imagic.GlobalCons"%>
 --%><%@page import="com.test.Oauth2callback"%>
 <%@page import="com.test.AddJdo"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
   <head>
       <link rel="stylesheet" type="text/css" href="/css/yourtodo.css">
   
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <%
         response.setHeader("Cache-Control","no-cache");
         response.setHeader("Cache-Control","no-store");
         response.setHeader("Pragma","no-cache");
         response.setDateHeader ("Expires", 0);
         String loggedInUser = (String) session.getAttribute("email");
             if(session.getAttribute("email")==null){
             	response.sendRedirect(request.getContextPath() + "/home");
         	}
         %>
      <title>Your Todo</title>
      
   </head>
   <style>
     
   </style>
   <body onload="loading()">
   			 		<body background="http://cdn.pcwallart.com/images/light-blue-background-wallpaper-2.jpg">
   
   	  <a href="/logout">Logout</a>
        <!-- <a href="/logout" class="btn btn-info btn-lg">
          <span class="glyphicon glyphicon-log-out"></span> Logout
        </a> -->
        
	  <h1>Welcome <%=session.getAttribute("email")%></h1>
	  
	  
	  
	     <center>  <h1>My To Do List</h1> </center> 
	  
      <div id="myDIV" class="header">
         <input type="text" id="inputText" placeholder="What needs to be done?" style=margin-left:163px;
         onkeypress="keyCode(event);">
         <span onclick="addElement();" class="addBtn">Add</span>
      </div>
      <center><ul id="todo">
      </ul></center>
      <script type="text/javascript">
         var todoArray = [];
         var myNodelist = document.getElementsByTagName("LI");
         var i;
         for (i = 0; i < myNodelist.length; i++) {
           var span = document.createElement("SPAN");
           var txt = document.createTextNode("\u00D7");
           span.className = "close";
           span.appendChild(txt);
           myNodelist[i].appendChild(span);
         }
         
         // Click on a close button to hide the current list item
         
         
         var close = document.getElementsByClassName("close");
         var i;
         for (i = 0; i < close.length; i++) {
           close[i].onclick = function() {
             var div = this.parentElement;
             div.style.display = "none";
           }
         }
         
         
         // Add a "checked" symbol when clicking on a list item
         /* var list = document.querySelector('ul');
         list.addEventListener('click', function(ev) {
           if (ev.target.tagName === 'LI') {
             ev.target.classList.toggle('checked');
           }
         }, false); */
         
         function loading(){
         	var email = '<%=loggedInUser%>';
         	var xhttp = new XMLHttpRequest();
         	  xhttp.onreadystatechange = function() {
         	    if (this.readyState == 4 && this.status == 200) {
         	    	
         	    	try {
                         var data = JSON.parse(xhttp.responseText);
                         
                         for(var item in data) {
         	                  var li = document.createElement("li");
         	           	      var t = document.createTextNode(data[item].name);
         	           	      var div = document.createElement("div");
         	           	      var id = data[item].key;
         	           	      var status = data[item].status;
         	           	      li.setAttribute("id", id);
         	           	      if( status  == "inactive")
         	           	      {
         	           	    	div.className = "checked";
         	           	      } else {
         	           	      	div.className = "active";
         	           	      }
         	           	      //li.appendChild(t);
         	           	      li.appendChild(div);
         	           	      div.appendChild(t);
         	           	      div.setAttribute("id",id);
         	           	      document.getElementById("todo").appendChild(li);
         	           	    
         	           	      
         	           		 $('#todo div').unbind('click').bind('click',function(e){
         	          			var id = $(this).attr("id");
         	          			if ( $( this ).hasClass( "checked" ) ) {
         	          					$( this ).removeClass( "checked" );
         	          			 		status = "active";
         	          			 		update(id,status);
         	          			 		return false;
         	          			 		
         	          			    }  else {
         	          			    	$( this ).addClass( "checked" );
         	          			    	status = "inactive";
         	          			 		update(id,status);
         	          			 		return false;
         	          			    }
         	          			
         	          	}); 
         	           	      document.getElementById("inputText").value = "";
         	           	      var span = document.createElement("TEXTBOX");
         	           	      var txt = document.createTextNode("\u00D7");
         	           	      span.className = "close";
         	           	      span.setAttribute("id", id);
         	           	      span.appendChild(txt);
         	           	      li.appendChild(span);
         	           	      todoArray.push(id);
         	             $('.close').unbind('click').bind('click',function(e){
         	           		var id = $(this).attr("id");
         	           		
         	           		var index = todoArray.indexOf(id);
         	           		
         	           		if (index > -1) {
         	           			var del = todoArray.splice(index, 1);
         	           			loadDoc(del);
         	           		}
         
         
         	           		console.log(todoArray);
         	           		$(this).parent().hide();
         	           	});
                         }
                         
                     } catch(err) {
                         console.log(err.message + " in " + xhttp.responseText);
                         return;
                     }
         	    	
         	      }
         	  };
         	  xhttp.open("POST", "/addJdo?email="+email, true);
         	  xhttp.send();
         	}
         function keyCode(event){
        	 var x = event.keyCode;
        	 if(x == 13){
        		 addElement();
        		 return false;
        	 }
        	 else{
        		 return false;
        	 }
         }
         function addElement(){
         	  var email = '<%=loggedInUser%>';
         	  var li = document.createElement("li");
         	  var div = document.createElement("div");
         	  var id = guid();
         	  var status = "active";
         	  li.setAttribute("id", id);
         	  var inputValue = document.getElementById("inputText").value;
         	  var t = document.createTextNode(inputValue);
         	  li.appendChild(div);
         	  div.appendChild(t);
         	  div.setAttribute("id",id);
         	  if (inputValue === '') {
         	    alert("Please provide a task!");
         	    return;
         	  } else {
         		  
         	    document.getElementById("todo").appendChild(li);
         	  }
         	 $('#todo div').unbind('click').bind('click',function(e){
         			var id = $(this).attr("id");
         			if ( $( this ).hasClass( "checked" ) ) {
         					$( this ).removeClass( "checked" );
         			 		status = "active";
         			 		update(id,status);
         			 		return false;
         			    }  else {
         			    	$( this ).addClass( "checked" );
         			    	status = "inactive";
         			 		update(id,status);
         			 		return false;
         			    }
         			
         	}); 
         	  document.getElementById("inputText").value = "";
         	  var span = document.createElement("TEXTBOX");
         	  var txt = document.createTextNode("\u00D7");
         	  span.className = "close";
         	  span.setAttribute("id", id);
         	  span.appendChild(txt);
         	  li.appendChild(span);
         		todoArray.push(id);
         		 $('.close').unbind('click').bind('click',function(e){
         				var id = $(this).attr("id");
         				
         				var index = todoArray.indexOf(id);
         				
         				if (index > -1) {
         					var del = todoArray.splice(index, 1);
                    			loadDoc(del);
         				}
         
         
         				console.log(todoArray);
         				$(this).parent().hide();
         				
         			});
         		 
         		  var myObj = {};
         
         		  myObj.name = inputValue;
         		  myObj.key  = id;
         		  myObj.email = email;
         		  myObj.status = status;
         		  
         		  console.log(myObj);
         		  // test for sorting
         		  
         		  
         		  
         		  
         		  // test for sorting
         		  
         		  
         		  
         		  
         		  
         		  addTodo(myObj);
         		}
         		function addTodo(myObj) {
         			  var xhttp = new XMLHttpRequest();
         			  xhttp.onreadystatechange = function() {
         			    if (this.readyState == 4 && this.status == 200) {
         			    	console.log("added");
         			    }
         			  };
         			  xhttp.open("POST", "/addTodo?todoArray="+JSON.stringify(myObj), true);
         			  xhttp.send();
         			}
         //UUID
         function guid() {
         	  function s4() {
         	    return Math.floor((1 + Math.random()) * 0x10000)
         	      .toString(16)
         	      .substring(1);
         	  }
         	  return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
         	    s4() + '-' + s4() + s4() + s4();
         	}
         
         
         function update(id,status) {
         		  var xhttp = new XMLHttpRequest();
         		  xhttp.onreadystatechange = function() {
         		    if (this.readyState == 4 && this.status == 200) {
         		      console.log("Status changed");
         		    }
         		  };
         		  xhttp.open("POST", "/update?status="+status+"&key="+id, true);
         		  xhttp.send();
         		} 
         		
         function loadDoc(del) {
         	  var xhttp = new XMLHttpRequest();
         	  xhttp.onreadystatechange = function() {
         	    if (this.readyState == 4 && this.status == 200) {
         	    	console.log("deleted");
         	    }
         	  };
         	  xhttp.open("POST", "/delTodo?delElement="+del, true);
         	  xhttp.send();
         	}
      </script>
   </body>
</html>