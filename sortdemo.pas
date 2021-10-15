program sortdemo;

//**********************************************************************************************************************************
//
//  Demo program to show how to use the 'sort' unit
//
//  Copyright: (C) 2021, Zsolt Szakaly
//
//  This source is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as
//  published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.
//
//  This code is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
//
//  A copy of the GNU General Public License is available on the World Wide Web at <http://www.gnu.org/copyleft/gpl.html>. You can
//  also obtain it by writing to the Free Software Foundation, Inc., 51 Franklin Street - Fifth Floor, Boston, MA 02110-1335, USA.
//
//**********************************************************************************************************************************
//
//  Description
//
//  It creates an array of records, prints it, sorts it and prints again to show how the sorting works
//  Just run it in a terminal
//
//**********************************************************************************************************************************

uses
  quicksort;

type
  tUser = record
    Name : string;
    Score : double;
    end;
  tUsers = array of tUser;

var
  Users : tUsers = nil;
  i : integer;

function CompareScores(const aUser1, aUser2) : integer;
  var
    record1 : tUser absolute aUser1;
    record2 : tUser absolute aUser2;
  begin
  if record1.Score = record2.Score then result := 0 else
  if record1.Score < record2.Score then result := -1 else
  result := 1;
  end;

begin
SetLength(Users, 10);
Users[0].Name := 'Abc';
Users[1].Name := 'Bcd';
Users[2].Name := 'Cde';
Users[3].Name := 'Def';
Users[4].Name := 'Efg';
Users[5].Name := 'Fgh';
Users[6].Name := 'Ghi';
Users[7].Name := 'Hij';
Users[8].Name := 'Ijk';
Users[9].Name := 'Jkl';
for i:=0 to 9 do
  Users[i].Score := random;
Writeln('User list before sorting');
for i := 0 to 9 do
  with Users[i] do
    Writeln(Name,' ',Score:6:4);
AnySort(Users[0],length(users),sizeof(tUser),@CompareScores);
Writeln;
Writeln('User list after sorting');
for i := 0 to 9 do
  with Users[i] do
    Writeln(Name,' ',Score:6:4);
end.
