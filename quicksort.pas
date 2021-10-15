unit quicksort;

//**********************************************************************************************************************************
//
//  Pascal function to sort any array
//
//  Based on the source code published on https://wiki.freepascal.org/Array_sort
//  The text was reformatted to my style and a bug is fixed
//  Copyright: (C) 2021, Zsolt Szakaly
//
//  This code is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
//
//**********************************************************************************************************************************
//
//  Description
//
//  Define your own compare function and call the AnySort function
//
//**********************************************************************************************************************************

{$mode delphi}{$H+}

interface

type
  tCompareFunction = function (const element1, element2) : integer;

procedure AnySort(var aArray; aRecordCount : integer; aStride: integer; aCompareFunction: tCompareFunction);

implementation

type
  tByteArray = array[word] of byte;
  pByteArray = ^tByteArray;

procedure AnyQuickSort(var aArray; aIndexLow, aIndexHigh : integer; aStride : integer; aCompareFunction: tCompareFunction;
    var aSwapBuffer, aMedianBuffer);
  var
    StrideLow, StrideHigh, StrideMedian : integer;
    IndexLow, IndexHigh, IndexMedian : integer;
    ByteArray : pByteArray;
  begin
  ByteArray := @aArray;
  IndexLow := aIndexLow;
  IndexHigh := aIndexHigh;
  IndexMedian := (IndexLow+IndexHigh) div 2;
  StrideLow := IndexLow * aStride;
  StrideHigh := IndexHigh * aStride;
  StrideMedian := IndexMedian*aStride;
  move(ByteArray[StrideMedian], aMedianBuffer, aStride);
  repeat
    while aCompareFunction(ByteArray[StrideLow], aMedianBuffer) < 0 do
      begin
      inc(StrideLow, aStride);
      inc(IndexLow);
      end;
    while aCompareFunction(aMedianBuffer, ByteArray[StrideHigh] ) < 0 do
      begin
      dec(StrideHigh, aStride);
      dec(IndexHigh);
      end;
    if StrideLow <= StrideHigh then
      begin
      Move(ByteArray[StrideLow], aSwapBuffer, aStride);
      Move(ByteArray[StrideHigh], ByteArray[StrideLow], aStride);
      Move(aSwapBuffer, ByteArray[StrideHigh], aStride);
      if IndexLow = IndexMedian then
        StrideMedian := StrideHigh;
      if IndexHigh = IndexMedian then
        StrideMedian := StrideLow;
      inc(IndexLow);
      inc(StrideLow, aStride);
      dec(IndexHigh);
      dec(StrideHigh, aStride);
      end;
    until StrideLow > StrideHigh;
  if IndexHigh > aIndexLow then
    AnyQuickSort(aArray, aIndexLow, IndexHigh, aStride, aCompareFunction, aSwapBuffer, aMedianBuffer);
  if IndexLow < aIndexHigh then
    AnyQuickSort(aArray, IndexLow, aIndexHigh, aStride, aCompareFunction, aSwapBuffer, aMedianBuffer);
  end;

procedure AnySort(var aArray; aRecordCount : integer; aStride: integer; aCompareFunction: tCompareFunction);
  var Buffer : array of byte = nil;
  begin
  if aRecordCount <= 1 then
    exit;
  SetLength(Buffer, aStride*2);
  AnyQuickSort(aArray, 0, aRecordCount-1, aStride, aCompareFunction, Buffer[0], Buffer[aStride]);
  end;

end.
