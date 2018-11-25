<?
/*
Using AJAX To Update A Non-Map DIV Via Google Maps API's GDownload() And GMarker OnClick Event
Copyright 2007 Doug Vanderweide
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
if(!preg_match('/^[0-7]{1,1}$/', $_GET['pid'])) {
	die('Input values out of range');
}
else {
	$host = "localhost";
	$user = "mysqluser";
	$pass = "mysqlpass";
	$db = "mydatabase";
	
	mysql_connect($host, $user, $pass) or die('Cannot connect to database server');
	mysql_select_db($db) or die('Cannot select database');
	
	$sql = "SELECT * FROM ajax_google_maps_detaildiv WHERE record_id = $_GET[pid]";
	$rs = mysql_query($sql) or die('Cannot parse query');
	
	if(mysql_num_rows($rs) == 0) {
		echo "<p><em>No matching record found.</em></p>\n";
	}
	else {
		$row = mysql_fetch_array($rs);
		if(!is_null($row['item_image'])) {
			echo "<img src=\"$row[item_image]\" alt=\"$row[item_title]\" style=\"float: right; margin-left: 5px;\" />\n";
		}
		echo "<h1>$row[item_title]</h1>\n";
		echo "<p><strong>Year constructed:</strong> $row[item_year]</p>\n";
		echo str_replace("\n", "<br />", $row['item_description']);
	}
}
?>