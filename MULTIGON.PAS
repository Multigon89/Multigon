{ Program: Multigon 1989, 2021 }

{ Multigon89:                                                      }
{ * First NFT series based on vintage code                         }
{ * Provably non-curated collectible art                           }
{ * Art composed of future ethereum block header hashes            }
{ * A 512-piece algorithmic artwork series with progammed scarcity }

{ How? }
{ * A set of integers from an ETH ethererum hash define parameteres of an image }
{ * This process is reproducibile in that the same hash yields the same image   }

{ How is this provably non-curated? Deterministic? }
{ * 512 future consecutive ethereum blocks are included directly in this source code }
{ * A SHA256 hash of source code will be saved on-chain prior to the mining of these blocks }
{ *  After the blocks are mined, this program will be applied to the block header hashes }
{ *  Anyone in the future can.....  }
{      1. prove the source code used to generate the images was locked prior to mining of embedded pre-defined block #'s }
{      2. run the source code on the block # hashes to re-generate the images  }

{ History }
{ * Most of the code was written in 1989 using MS-DOS and Turbo Pascal.   }
{ * The code was resurrected in 2021 and adjusted to modern digital art,  }
{     while maintaining the historic software versions of DOS and Pascal.   }

{ The ethereum hash defines:                                        }
{  * Number of points in the shape                                  }
{  * X,Y coordinates of each point                                  }
{  * The X,Y sequence to create a multi-sided shape                 }
{  * Color of shape and background                                  }
{  * Solid fill vs simple pattern vs complex pattern                }

{ Programmed Scarcity - based on the ethereum hash  }
  { Shape Points }
      { 16 point, 92% }
      { 24 points, 5% }
      { 32 points, 2% }
      { 40 points, 1% }
  { Multigon Pattern }
      { solid, 80% }
      { simple, 18% }
      { complex, 2% }
  { Background Pattern }
      { solid, 18% }
      { simple, 80% }
      { complex, 2% }

{ Environment }
{ * The circa 1989 enviornment was MS-DOS 3.3 with Turbo Pascal v5.0. }
{ * The 2021 enviornment is DOSBox 0.74-3-3 and the exact same        }
{    1989 copy of Turbo Pascal v5.0                                   }
{ * The canvas is 450 x 450 pixels with 15 colors                     }

{ Ethereum Block Numbers}
{ * This program will be run sequentially on the following 512 ethereum blocks. }
{ * While treating the blocks sequentially, the Nth hash will correspond to the Nth NFT }
{ * The NFTs will be sequentially numbered 1 - 512 to align with the sequence of the block hashes. }
{ * Block numbers 13557400 through 13557911 *}


{Instructions}
{1. Prepare a text file containing 1 ethereum hash per line. The file may contain up to 200 hashes}
{2. Note that the program assumes the hash starts with 0x }
{3. Start the program. The user enters the filepath and name of the text file}
{4. The prog will prompt for the name of an output text file. This is used to store scarcity metadata. }
{5. The prog will load the hashes into an array. For each hash the program will display a unique collectible}
{6. The hashes are displayed sequentially with a programmed delay in between images.  }
{7. The output text file containing metadata is saved and closed by the program}
{Note: User created text files should be generated in Unicode UTF-8 in CRLF format}

program multigon;
uses crt, dos, graph, grdrivers;

const
     MaxPoints = 41;
     {one greater than num of points since need to close the multigon}
	 {so actual max is 40 point multigon}

VAR
   graphdriver, graphMode :integer;
   xMax, YMax : Word;  { note that sampling array expects WORD }
   ratio : real; {divide hash integers by the max possible integer}
   Blocknum, Blockmax, h, hh : longint; {hash math related}
   xx, yy : Word;
   hash: ARRAY [1 .. 200] of string;  {hash that is read from file}
   n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12,n13,n14,n15,n16,n17,n18,n19,n20,d,j: longint; {hash related}
   c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c20: integer; {error code related}
   polyPoints : ARRAY [1 .. MaxPoints ] of PointType; {contains multigon coordinates}
   squarePoints : ARRAY [1 .. 4] of PointType;   {contains background square coordinates}
   NormPat : FillPatternType ; {variable for a normal fill pattern }
   ComplexPat : FillPatternType ; {variable for a complex fill pattern }
   i, rows, ActualPoints, MyPoints : integer;
   e, buPattern, muPattern, v, outfile : string;
   f, g : text; {assign as a text file}
   s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15,s16,s17,s18,s19,s20 : string;
   FillColorPoly, FillColorSquare : integer;

BEGIN
Writeln('Enter a text file name containing one ethereum block hash per line.');
Writeln('Example: C:\thehash.txt ');
Readln(e);
Writeln('How many hashes should be read? ');
Writeln('Note that maximum per file = 200 hashes ');
Readln(rows);
Assign(f,e); {assign user entered string as file f}
Reset(f);  {opens the file of var f}

i := 1;
REPEAT
Readln(f,hash[i]);
i := i + 1;
UNTIL i > rows;

Close(f);
{ file is closed. The hashes have been read into array called hash }
{hash length is 66 char long, only trailing 64 hex digits are used }

Writeln('What folder path and filename do you want to save metadata ?');
Writeln('Example: C:\text.txt  ');
Readln(outfile); {will contain certain metadata for each image generated}
Assign(g, outfile);


Rewrite(g);
Writeln(g, 'Index Vertices MultiPattern BackPattern');

ClrScr;

i := 1;
REPEAT

graphdriver := Detect;
InitGraph(graphDriver, graphmode, '');
Clearviewport;

s1 := copy(hash[i],3,4); {start at string index 3, copy 4 char into s1}
Insert('$',s1,1); {insert a $ prefix to define as hex}
s2 := copy(hash[i],7,4); Insert('$',s2,1);
s3 := copy(hash[i],11,4); Insert('$',s3,1);
s4 := copy(hash[i],15,4); Insert('$',s4,1);
s5 := copy(hash[i],19,4); Insert('$',s5,1);
s6 := copy(hash[i],23,4); Insert('$',s6,1);
s7 := copy(hash[i],27,4); Insert('$',s7,1);
s8 := copy(hash[i],31,4); Insert('$',s8,1);
s9 := copy(hash[i],35,4); Insert('$',s9,1);
s10:= copy(hash[i],39,4); Insert('$',s10,1);
s11 := copy(hash[i],43,4); Insert('$',s11,1);
s12 := copy(hash[i],47,4); Insert('$',s12,1);
s13 := copy(hash[i],51,4); Insert('$',s13,1);
s14 := copy(hash[i],55,4); Insert('$',s14,1);
s15 := copy(hash[i],59,4); Insert('$',s15,1);
s16 := copy(hash[i],63,4); Insert('$',s16,1);
s17 := copy(hash[i],9,4); Insert('$',s17,1); {from this point on, sample non-contiguous segments of hash}
s18 := copy(hash[i],32,4); Insert('$',s18,1);
s19 := copy(hash[i],54,4); Insert('$',s19,1);
s20:= copy(hash[i],25,4); Insert('$',s20,1);

{s1 thru s13 generates a series of sub-strings to work toward 13 pt multigon}
Val(s1,n1,c1); {turn the string s1 into longint n1, then convert to a ratio}
Val(s2,n2,c2); {repeat for each. c1,c2, etc are error code.}
Val(s3,n3,c3); Val(s4,n4,c4); Val(s5,n5,c5); Val(s6,n6,c6);
Val(s7,n7,c7); Val(s8,n8,c8); Val(s9,n9,c9); Val(s10,n10,c10);
Val(s11,n11,c11); Val(s12,n12,c12); Val(s13,n13,c13);
Val(s14,n14,c14); Val(s15,n15,c15); Val(s16,n16,c16);
Val(s17,n17,c17); Val(s18,n18,c18); Val(s19,n19,c19); Val(s20,n20,c20);

h := $FFFF ; {this is the max integer size, 65535}
xMax := 450; yMax := 450; {set the canvas to 450 x 450 pixels}
d := (n2 + n4 + n6 + n8 + n10) DIV 5; {d and j help define points 21-40 where applicable}
j := (n11 + n13 + n15 + n17) DIV 4;

PolyPoints[1].x := Round(n1/h*xMax); PolyPoints[1].y := Round(n6/h*yMax);
PolyPoints[2].x := Round(n2/h*xMax); PolyPoints[2].y := Round(n8/h*yMax);
PolyPoints[3].x := Round(n3/h*xMax); PolyPoints[3].y := Round(n3/h*yMax);
PolyPoints[4].x := Round(n4/h*xMax); PolyPoints[4].y := Round(n14/h*yMax);
PolyPoints[5].x := Round(n5/h*xMax); PolyPoints[5].y := Round(n17/h*yMax);
PolyPoints[6].x := Round(n6/h*xMax); PolyPoints[6].y := Round(n15/h*yMax);
PolyPoints[7].x := Round(n7/h*xMax); PolyPoints[7].y := Round(n13/h*yMax);
PolyPoints[8].x := Round(n8/h*xMax); PolyPoints[8].y := Round(n11/h*yMax);
PolyPoints[9].x := Round(n9/h*xMax); PolyPoints[9].y := Round(n2/h*yMax);
PolyPoints[10].x := Round(n10/h*xMax); PolyPoints[10].y := Round(n1/h*yMax);
PolyPoints[11].x := Round(n11/h*xMax); PolyPoints[11].y := Round(n20/h*yMax);
PolyPoints[12].x := Round(n12/h*xMax); PolyPoints[12].y := Round(n10/h*yMax);
PolyPoints[13].x := Round(n13/h*xMax); PolyPoints[13].y := Round(n12/h*yMax);
PolyPoints[14].x := Round(n14/h*xMax); PolyPoints[14].y := Round(n8/h*yMax);
PolyPoints[15].x := Round(n15/h*xMax); PolyPoints[15].y := Round(n19/h*yMax);
PolyPoints[16].x := Round(n16/h*xMax); PolyPoints[16].y := Round(n4/h*yMax);
PolyPoints[17].x := Round(n17/h*xMax); PolyPoints[17].y := Round(n7/h*yMax);
PolyPoints[18].x := Round(n18/h*xMax); PolyPoints[18].y := Round(n9/h*yMax);
PolyPoints[19].x := Round(n19/h*xMax); PolyPoints[19].y := Round(n16/h*yMax);
PolyPoints[20].x := Round(n20/h*xMax); PolyPoints[20].y := Round(n5/h*yMax);
PolyPoints[21].x := Round((d + n20)/h*xMax/2); PolyPoints[21].y := Round((j + n2)/h*yMax/2);
PolyPoints[22].x := Round((d + n19)/h*xMax/2); PolyPoints[22].y := Round((j + n4)/h*yMax/2);
PolyPoints[23].x := Round((d + n18)/h*xMax/2); PolyPoints[23].y := Round((j + n6)/h*yMax/2);
PolyPoints[24].x := Round((d + n17)/h*xMax/2); PolyPoints[24].y := Round((j + n8)/h*yMax/2);
PolyPoints[25].x := Round((d + n16)/h*xMax/2); PolyPoints[25].y := Round((j + n10)/h*yMax/2);
PolyPoints[26].x := Round((d + n15)/h*xMax/2); PolyPoints[26].y := Round((j + n12)/h*yMax/2);
PolyPoints[27].x := Round((d + n14)/h*xMax/2); PolyPoints[27].y := Round((j + n14)/h*yMax/2);
PolyPoints[28].x := Round((d + n13)/h*xMax/2); PolyPoints[28].y := Round((j + n16)/h*yMax/2);
PolyPoints[29].x := Round((d + n12)/h*xMax/2); PolyPoints[29].y := Round((j + n18)/h*yMax/2);
PolyPoints[30].x := Round((d + n11)/h*xMax/2); PolyPoints[30].y := Round((j + n20)/h*yMax/2);
PolyPoints[31].x := Round((d + n10)/h*xMax/2); PolyPoints[31].y := Round((j + n1)/h*yMax/2);
PolyPoints[32].x := Round((d + n9)/h*xMax/2); PolyPoints[32].y := Round((j + n3)/h*yMax/2);
PolyPoints[33].x := Round((d + n8)/h*xMax/2); PolyPoints[33].y := Round((j + n5)/h*yMax/2);
PolyPoints[34].x := Round((d + n7)/h*xMax/2); PolyPoints[34].y := Round((j + n7)/h*yMax/2);
PolyPoints[35].x := Round((d + n6)/h*xMax/2); PolyPoints[35].y := Round((j + n9)/h*yMax/2);
PolyPoints[36].x := Round((d + n5)/h*xMax/2); PolyPoints[36].y := Round((j + n11)/h*yMax/2);
PolyPoints[37].x := Round((d + n4)/h*xMax/2); PolyPoints[37].y := Round((j + n13)/h*yMax/2);
PolyPoints[38].x := Round((d + n3)/h*xMax/2); PolyPoints[38].y := Round((j + n15)/h*yMax/2);
PolyPoints[39].x := Round((d + n2)/h*xMax/2); PolyPoints[39].y := Round((j + n17)/h*yMax/2);
PolyPoints[40].x := Round((d + n1)/h*xMax/2); PolyPoints[40].y := Round((j + n18)/h*yMax/2);

{ Define coordinates of multigon using the hash segments}

v := 'error '; {cover scenario where no IF statement occurs}
If n9 <= 655 then {655 decimal is roughly 1 percent of FFFFF hex, which is 65535 decimal }
   begin
	ActualPoints := 41; {one greater than number of points}
	v := '40 ';  {v is for writing metadata to text file later}
	end;
If (n9 > 655) and (n9 <= 1965) then {roughly 2 percent of the time}
	begin
	ActualPoints := 33;
	v := '32 ';
	end;
If (n9 > 1965) AND (n9 <= 5241) then {roughly 5 percent of the time}
   begin
    ActualPoints := 25;
     v := '24 ';
   end;
If (n9 > 5241) AND (n9 <= 65535) then {roughly 92 percent of the time}
   begin
    ActualPoints := 17;
     v := '16 ';
   end;

polyPoints[ActualPoints] := polyPoints[1]; {ensures multigon is a closed shape}

squarePoints[1].x := 0;    squarePoints[1].y := 0;
squarePoints[2].x := xMax; squarePoints[2].y := 0;
squarePoints[3].x := xMax; squarePoints[3].y := yMax;
squarePoints[4].x := 0;    squarePoints[4].y := yMax;
{The above defines the array for the background, which is a square}

{Set fill color of multigon and then the square}
FillColorPoly :=   1 + trunc(n7/h*MaxColors); {set color of multigon}

{For each multigon color scenario, the following conditions set 1 of 4 background colors}
IF FillColorPoly = 1 {blue} then
   begin
       if (n1 <= n2) and (n3 <= n4) then
        FillColorSquare := 10; { light green}
       if (n1 <= n2) and (n3 > n4) then
         FillColorSquare := 7; {lightgray}
       if (n1 > n2) and (n3 <= n4) then
        FillColorSquare := 13; {light magenta}
       if (n1 > n2) and (n3 > n4) then
        FillColorSquare := 6; {brown}
    end;

IF FillColorPoly = 2 {green} then
   begin
       if (n1 <= n2) and (n3 <= n4) then
        FillColorSquare := 1;
       if (n1 <= n2) and (n3 > n4) then
         FillColorSquare := 4;
       if (n1 > n2) and (n3 <= n4) then
        FillColorSquare := 6;
       if (n1 > n2) and (n3 > n4) then
        FillColorSquare := 8;
    end;

IF FillColorPoly = 3 {cyan} then
   begin
       if (n1 <= n2) and (n3 <= n4) then
        FillColorSquare := 1;
       if (n1 <= n2) and (n3 > n4) then
         FillColorSquare := 8;
       if (n1 > n2) and (n3 <= n4) then
        FillColorSquare := 10;
       if (n1 > n2) and (n3 > n4) then
        FillColorSquare := 14;
    end;

IF FillColorPoly = 4 {red} then
   begin
       if (n1 <= n2) and (n3 <= n4) then
        FillColorSquare := 2;
       if (n1 <= n2) and (n3 > n4) then
         FillColorSquare := 7;
       if (n1 > n2) and (n3 <= n4) then
        FillColorSquare := 8;
       if (n1 > n2) and (n3 > n4) then
        FillColorSquare := 1;
    end;

IF FillColorPoly = 5 {magenta} then
   begin
       if (n1 <= n2) and (n3 <= n4) then
        FillColorSquare := 7;
       if (n1 <= n2) and (n3 > n4) then
         FillColorSquare := 11;
       if (n1 > n2) and (n3 <= n4) then
        FillColorSquare := 14;
       if (n1 > n2) and (n3 > n4) then
        FillColorSquare := 15;
    end;

IF FillColorPoly = 6 {brown} then
   begin
       if (n1 <= n2) and (n3 <= n4) then
        FillColorSquare := 7;
       if (n1 <= n2) and (n3 > n4) then
         FillColorSquare := 8;
       if (n1 > n2) and (n3 <= n4) then
        FillColorSquare := 14;
       if (n1 > n2) and (n3 > n4) then
        FillColorSquare := 15;
    end;

IF FillColorPoly = 7 {lightgray} then
   begin
       if (n1 <= n2) and (n3 <= n4) then
        FillColorSquare := 1;
       if (n1 <= n2) and (n3 > n4) then
         FillColorSquare := 2;
       if (n1 > n2) and (n3 <= n4) then
        FillColorSquare := 8;
       if (n1 > n2) and (n3 > n4) then
        FillColorSquare := 14;
    end;

IF FillColorPoly = 8 {darkgray} then
   begin
       if (n1 <= n2) and (n3 <= n4) then
        FillColorSquare := 7;
       if (n1 <= n2) and (n3 > n4) then
         FillColorSquare := 10;
       if (n1 > n2) and (n3 <= n4) then
        FillColorSquare := 11;
       if (n1 > n2) and (n3 > n4) then
        FillColorSquare := 13;
    end;

IF FillColorPoly = 9 {lightblue} then
   begin
       if (n1 <= n2) and (n3 <= n4) then
        FillColorSquare := 7;
       if (n1 <= n2) and (n3 > n4) then
         FillColorSquare := 10;
       if (n1 > n2) and (n3 <= n4) then
        FillColorSquare := 11;
       if (n1 > n2) and (n3 > n4) then
        FillColorSquare := 15;
    end;

IF FillColorPoly = 10 {lightgreen} then
   begin
       if (n1 <= n2) and (n3 <= n4) then
        FillColorSquare := 1;
       if (n1 <= n2) and (n3 > n4) then
         FillColorSquare := 2;
       if (n1 > n2) and (n3 <= n4) then
        FillColorSquare := 5;
       if (n1 > n2) and (n3 > n4) then
        FillColorSquare := 6;
    end;

IF FillColorPoly = 11 {lightCyan} then
   begin
       if (n1 <= n2) and (n3 <= n4) then
        FillColorSquare := 1;
       if (n1 <= n2) and (n3 > n4) then
         FillColorSquare := 2;
       if (n1 > n2) and (n3 <= n4) then
        FillColorSquare := 8;
       if (n1 > n2) and (n3 > n4) then
        FillColorSquare := 9;
    end;

IF FillColorPoly = 12 {lightRed} then
   begin
       if (n1 <= n2) and (n3 <= n4) then
        FillColorSquare := 8;
       if (n1 <= n2) and (n3 > n4) then
         FillColorSquare := 9;
       if (n1 > n2) and (n3 <= n4) then
        FillColorSquare := 10;
       if (n1 > n2) and (n3 > n4) then
        FillColorSquare :=11;
    end;

IF FillColorPoly = 13 {lightMagenta} then
   begin
       if (n1 <= n2) and (n3 <= n4) then
        FillColorSquare := 8;
       if (n1 <= n2) and (n3 > n4) then
         FillColorSquare := 10;
       if (n1 > n2) and (n3 <= n4) then
        FillColorSquare := 11;
       if (n1 > n2) and (n3 > n4) then
        FillColorSquare :=15;
    end;

IF FillColorPoly = 14 {yellow} then
   begin
       if (n1 <= n2) and (n3 <= n4) then
        FillColorSquare := 1;
       if (n1 <= n2) and (n3 > n4) then
         FillColorSquare := 2;
       if (n1 > n2) and (n3 <= n4) then
        FillColorSquare := 4;
       if (n1 > n2) and (n3 > n4) then
        FillColorSquare := 5;
    end;

IF FillColorPoly = 15 {white} then
   begin
       if (n1 <= n2) and (n3 <= n4) then
        FillColorSquare := 1;
       if (n1 <= n2) and (n3 > n4) then
         FillColorSquare := 2;
       if (n1 > n2) and (n3 <= n4) then
        FillColorSquare := 4;
       if (n1 > n2) and (n3 > n4) then
        FillColorSquare := 8;
    end;
{end of setting colors of multigon and background}

{for fill pattern, establish two scenarios, normPat and ComplexPat}

NormPat[1] := 255; NormPat[2] := 255; NormPat[3] := 255; NormPat[4] := 255;
NormPat[5] := 255; NormPat[6] := trunc(n6/h*255); NormPat[7] := 255; NormPat[8] := 255;

ComplexPat[1] := trunc(n11/h*255); ComplexPat[2] := trunc(n12/h*255);
ComplexPat[3] := trunc(n13/h*255);ComplexPat[4] := trunc(n14/h*255);
ComplexPat[5] := trunc(n15/h*255);ComplexPat[6] := trunc(n16/h*255);
ComplexPat[7] := trunc(n17/h*255);ComplexPat[8] := trunc(n18/h*255);

  {the fill pattern function accepts eight sets of 8 bits to make a }
  {custom pattern. This allows to turn on/off 64 pixels.}
  {For each of the 8 segments that define a pattern, n/h allows us to chose}
  {from among 255 possible sub-patterns. This results in 255^8 possible patterns}
  {for when the complex pattern type}

mupattern := 'error ';
bupattern := 'error '; {in case no IF THEN loop occurs}

{Solid pattern background, 18%}
IF n14 < 11797 then
	begin
		bupattern := 'solid ';
		If n15 <= 52428 then {80%, solid pattern multigon}
		  begin
          mupattern := 'solid ';
		  SetColor(FillColorSquare);
		   SetFillStyle(1,FillColorSquare); {sets as a solid pattern}
		   FillPoly(4,squarePoints);
                   SetColor(FillColorPoly);
 		   SetFillStyle(1, FillColorPoly); {sets as a solid pattern}
		   FillPoly(ActualPoints,polyPoints);
		   end;
	   If (n15 > 52428) and (n15 <= 64224) then {18%, simple pattern multigon}
	         begin
                  mupattern := 'simple ';
		   SetColor(FillColorSquare);
		   SetFillStyle(1,FillColorSquare); {sets as a solid pattern}
		   FillPoly(4,squarePoints);
		   SetColor(FillColorPoly);
		   SetBkColor(FillColorSquare);
		   SetFillPattern (NormPat, FillColorPoly); {Sets as simple pattern}
		   FillPoly(ActualPoints, polyPoints);
		  end;
         If (n15 >= 64224) and (n15 <= 65535) then {2%, complex pattern multigon}
            begin
			mupattern := 'complex ';
	      SetColor(FillColorSquare);
	      SetFillStyle(1,FillColorSquare); {sets as a solid pattern}
	      FillPoly(4,squarePoints);
	      SetColor(FillColorPoly);
	      SetBkColor(FillColorSquare);
	      SetFillPattern (ComplexPat, FillColorPoly); {Sets as complex pattern}
	      FillPoly(ActualPoints, polyPoints);
	     end;
   end;

{simple pattern background, 80%}
IF (n14 >= 11797) and (n14 < 64226) then
	begin
	bupattern := 'simple ';
		If n15 <= 52428 then {80%, solid pattern multigon}
		  begin
		  mupattern := 'solid ';
           SetColor(FillColorSquare);
		   SetBkColor(FillColorPoly);
		   SetFillPattern(NormPat,FillColorSquare); {sets as simple pattern}
		   FillPoly(4,squarePoints);
                   SetColor(FillColorPoly);
		   SetFillStyle(1, FillColorPoly); {sets as a solid pattern}
		   FillPoly(ActualPoints,polyPoints);
                  end;
	   If (n15 > 52428) and (n15 <= 64224) then {18%, simple pattern multigon}
	      begin
           mupattern := 'simple ';
		   SetColor(FillColorSquare);
		   SetBkColor(Black);
		   SetFillPattern(NormPat,FillColorSquare); {sets as simple pattern}
		   FillPoly(4,squarePoints);
		   SetColor(FillColorPoly);
		   SetFillPattern(NormPat, FillColorPoly); {Sets as simple pattern}
		   FillPoly(ActualPoints, polyPoints);
		  end;

      If (n15 >= 64224) and (n15 <= 65535) then {2%, complex pattern multigon}
         begin
          mupattern := 'complex ';
		  SetColor(FillColorSquare);
	      SetBkColor(Black);
	      SetFillPattern(NormPat,FillColorSquare); {sets as simple pattern}
	      FillPoly(4,squarePoints);
	      SetColor(FillColorPoly);
	      SetFillPattern(ComplexPat, FillColorPoly); {Sets as complex pattern}
	      FillPoly(ActualPoints, polyPoints);
	     end;
   end;

{complex pattern background 2%}
IF (n14 >= 64226) and (n14 <= 65535) then
	begin
		bupattern := 'complex ';
		If n15 <= 52428 then {80%, solid pattern multigon}
		  begin
           mupattern := 'solid ';
		   SetColor(FillColorSquare);
		   SetBkColor(FillColorPoly);
		   SetFillPattern(ComplexPat,FillColorSquare); {sets as complex pattern}
		   FillPoly(4,squarePoints);
                   SetColor(FillColorPoly);
		   SetFillStyle(1, FillColorPoly); {sets as a solid pattern}
		   FillPoly(ActualPoints,polyPoints);
                  end;
	   If (n15 > 52428) and (n15 <= 64224) then {18%, simple pattern multigon}
	      begin
           mupattern := 'simple ';
		   SetColor(FillColorSquare);
		   SetBkColor(Black);
		   SetFillPattern(ComplexPat,FillColorSquare); {sets as complex pattern}
		   FillPoly(4,squarePoints);
		   SetColor(FillColorPoly);
		   SetFillPattern(NormPat, FillColorPoly); {Sets as simple pattern}
		   FillPoly(ActualPoints, polyPoints);
		  end;
       If (n15 >= 64224) and (n15 <= 65535) then {2%, complex pattern multigon}
         begin
          mupattern := 'complex ';
		  SetColor(FillColorSquare);
	      SetBkColor(Black);
	      SetFillPattern(ComplexPat,FillColorSquare); {sets as complex pattern}
	      FillPoly(4,squarePoints);
	      SetColor(FillColorPoly);
	      SetFillPattern(ComplexPat, FillColorPoly); {Sets as complex pattern}
	      FillPoly(ActualPoints, polyPoints);
	     end;
   end;

Writeln(g,i,'  ',v,muPattern,buPattern);
{all 3 of these are strings. Write scarcity info to the output file}

Delay (4000);

Closegraph;

i := i+1;
UNTIL i > rows;
close(g);
END.