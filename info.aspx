<%@ Page Language="VB"%>
<%@ Import Namespace="System.Text.RegularExpressions" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">
	'Using AJAX To Update A Non-Map DIV Via Google Maps API's GDownload() And GMarker OnClick Event
	'Copyright 2007 Doug Vanderweide, dba Rescue-ME
	'http://www.dougv.com
	'
	'Distributed under the Creative Commons Attribution / Share-Alike License
	'http://creativecommons.org/licenses/by-sa/3.0/
	'
	'Any distribution or derivative work based on this script must include the
	'original source code from this work, and must retain this copyright
	'notice block intact.

	Sub Page_Load(Sender As Object, E As EventArgs)
		Dim strOut As String
		
		Dim reInput As New Regex("^[0-7]{1,1}$")
		If Not reInput.IsMatch(Request.QueryString("pid")) Then
			strOut = "<p>Input out of range.</p>"
		Else
			strOut = GetRecord(Request.QueryString("pid"))
		End If
		
		Response.ContentType = "text/plain"
		Response.Write(strOut)
	End Sub
	
	Function GetRecord(intID As Integer) As String
		Dim strOut As String
		
		Dim objConn As New SqlConnection("your connection string")
		Dim objCmd As New SqlCommand("SELECT * FROM mapstable WHERE record_id = " & intID, objConn)
		objCmd.CommandType = CommandType.Text
		
		objConn.Open()
		Dim objReader As SqlDataReader = objCmd.ExecuteReader()
		If Not objReader.HasRows() Then
			strOut = "<p>No matching records found</p>"
		Else
			objReader.Read()
			Dim strBody As String = objReader("item_description")
			strOut = "<h1>" + objReader("item_title") + "</h1>" + vbCrLf
			strOut += "<p><strong>Year constructed:</strong> " + objReader("item_year") + "</p>" + vbCrLf
			strOut += strBody.Replace(vbCrLf, "<br /")
		End If
		
		objReader.Close()
		objConn.Close()
		objCmd.Dispose()
		objConn.Dispose()
		
		Return strOut
		End Function
</script>
