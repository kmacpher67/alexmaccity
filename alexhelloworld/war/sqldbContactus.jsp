<%@ page import="java.sql.*" %>


<HTML> 
  <HEAD> 
    <TITLE>
       SimpleQuery JSP
    </TITLE>
  </HEAD>
 <BODY BGCOLOR=EOFFFO> 
 <H1> Hello 
  <%= (request.getRemoteUser() != null? ", " + request.getRemoteUser() : "") %>
 !  I am SimpleQuery JSP.
 </H1>
 <HR>
 <B> I will do a basic JDBC query to get employee data  
     from EMP table in schema SCOTT..
 </B> 

 <P>
<%
    try {
      // Use the following 2 files whening running inside Oracle 8i
      // Connection conn = new oracle.jdbc.driver.OracleDriver().
      //                     defaultConnection ();
      Connection  conn = 
          DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe",
                                           "system", "onbc29");
      Statement stmt = conn.createStatement ();
      ResultSet rset = stmt.executeQuery ("select * from contactinfo");
      if (rset.next()) {
%>
     <TABLE BORDER=1 BGCOLOR="C0C0C0">
     <TH WIDTH=200 BGCOLOR="white"> <I>Employee Name</I> </TH>
     <TH WIDTH=100 BGCOLOR="white"> <I>Salary</I> </TH>
     <TR> <TD ALIGN=CENTER> <%= rset.getString(1) %> </TD>
          <TD ALIGN=CENTER> $<%= rset.getDouble(2) %> </TD>
     </TR>

<%     while (rset.next()) {
%>

     <TR> <TD ALIGN=CENTER> <%= rset.getString(1) %> </TD>
          <TD ALIGN=CENTER> $<%= rset.getDouble(2) %> </TD>
     </TR>

<% }
%>
      </TABLE>
<%  } 
      else {
%>
     <P> Sorry, the query returned no rows! </P>

<% 
      }
      rset.close();
      stmt.close();
    } catch (SQLException e) {
      out.println("<P>" + "There was an error doing the query:");
      out.println ("<PRE>" + e + "</PRE> \n <P>");
    }
%>

 </BODY>
</HTML>