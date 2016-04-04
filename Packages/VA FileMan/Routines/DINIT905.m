DINIT905 ;GFT/GFT-DIALOG FILE INITS ;06:24 PM  21 Aug 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999**
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,8153,2,0)
 ;;=^^1^1^2990711^^^^
 ;;^UTILITY(U,$J,.84,8153,2,1,0)
 ;;=  '+' to mean |1|, etc.
 ;;^UTILITY(U,$J,.84,8153,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8153,3,1,0)
 ;;=1^NEXT LINE NUMBER
 ;;^UTILITY(U,$J,.84,8153,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8153,5,1,0)
 ;;=DIWE5^LNQ+2
 ;;^UTILITY(U,$J,.84,8155,0)
 ;;=8155^2^^2
 ;;^UTILITY(U,$J,.84,8155,2,0)
 ;;=^^8^8^2991008^^
 ;;^UTILITY(U,$J,.84,8155,2,1,0)
 ;;=You have 30 seconds to start sending text.
 ;;^UTILITY(U,$J,.84,8155,2,2,0)
 ;;=An End-of-File is assumed on 30-second timeout.
 ;;^UTILITY(U,$J,.84,8155,2,3,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,8155,2,4,0)
 ;;=TABs are converted to 1 thru 9 spaces to start the next character
 ;;^UTILITY(U,$J,.84,8155,2,5,0)
 ;;=at a column evenly divisible by 9, plus 1.  (10,19,28,37,...)
 ;;^UTILITY(U,$J,.84,8155,2,6,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,8155,2,7,0)
 ;;=End-of-line = Carriage Return/$C(13)  or Escape/$C(27).
 ;;^UTILITY(U,$J,.84,8155,2,8,0)
 ;;=All other control characters will be stripped from the text.
 ;;^UTILITY(U,$J,.84,8155,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8155,5,1,0)
 ;;=DIWE11
 ;;^UTILITY(U,$J,.84,8156,0)
 ;;=8156^2^^2
 ;;^UTILITY(U,$J,.84,8156,2,0)
 ;;=^^1^1^2991027^
 ;;^UTILITY(U,$J,.84,8156,2,1,0)
 ;;=Maximum STRING LENGTH
 ;;^UTILITY(U,$J,.84,8156,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8156,5,1,0)
 ;;=DIWE5
 ;;^UTILITY(U,$J,.84,8157,0)
 ;;=8157^2^^2
 ;;^UTILITY(U,$J,.84,8157,2,0)
 ;;=^^1^1^2991027^
 ;;^UTILITY(U,$J,.84,8157,2,1,0)
 ;;=FILE TRANSFER COMPLETED.
 ;;^UTILITY(U,$J,.84,8157,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8157,5,1,0)
 ;;=DIWE5
 ;;^UTILITY(U,$J,.84,8160,0)
 ;;=8160^2^^2
 ;;^UTILITY(U,$J,.84,8160,2,0)
 ;;=^^1^1^2991027^^
 ;;^UTILITY(U,$J,.84,8160,2,1,0)
 ;;=REQUESTED TIME TO PRINT
 ;;^UTILITY(U,$J,.84,8160,5,0)
 ;;=^.841^2^2
 ;;^UTILITY(U,$J,.84,8160,5,1,0)
 ;;=DIP4^W
 ;;^UTILITY(U,$J,.84,8160,5,2,0)
 ;;=DIWE4^QUE+1
 ;;^UTILITY(U,$J,.84,8161,0)
 ;;=8161^2^y^2
 ;;^UTILITY(U,$J,.84,8161,2,0)
 ;;=^^1^1^2991027^
 ;;^UTILITY(U,$J,.84,8161,2,1,0)
 ;;=REQUEST QUEUED...  Task |1|.
 ;;^UTILITY(U,$J,.84,8161,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8161,3,1,0)
 ;;=1^TASK NUMBER
 ;;^UTILITY(U,$J,.84,8161,5,0)
 ;;=^.841^2^2
 ;;^UTILITY(U,$J,.84,8161,5,1,0)
 ;;=DIP4^ZTM+2
 ;;^UTILITY(U,$J,.84,8161,5,2,0)
 ;;=DIWE4^QUE+4
 ;;^UTILITY(U,$J,.84,8162,0)
 ;;=8162^2^^2
 ;;^UTILITY(U,$J,.84,8162,2,0)
 ;;=^^1^1^2991027^
 ;;^UTILITY(U,$J,.84,8162,2,1,0)
 ;;=Do you want Line Numbers
 ;;^UTILITY(U,$J,.84,8162,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8162,5,1,0)
 ;;=DIWE4^LINNUMS
 ;;^UTILITY(U,$J,.84,8163,0)
 ;;=8163^2^^2
 ;;^UTILITY(U,$J,.84,8163,2,0)
 ;;=^^1^1^2991027^
 ;;^UTILITY(U,$J,.84,8163,2,1,0)
 ;;=Rough Draft
 ;;^UTILITY(U,$J,.84,8163,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8163,5,1,0)
 ;;=DIWE4^RD
 ;;^UTILITY(U,$J,.84,8164,0)
 ;;=8164^3^^2
 ;;^UTILITY(U,$J,.84,8164,2,0)
 ;;=^^1^1^2991027^
 ;;^UTILITY(U,$J,.84,8164,2,1,0)
 ;;=A rough draft is printed line-for-line, showing windows.
 ;;^UTILITY(U,$J,.84,8164,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8164,5,1,0)
 ;;=DIWE4^RD
 ;;^UTILITY(U,$J,.84,8165,0)
 ;;=8165^2^^2
 ;;^UTILITY(U,$J,.84,8165,2,0)
 ;;=^^1^1^2991027^
 ;;^UTILITY(U,$J,.84,8165,2,1,0)
 ;;=Line Editor Print
 ;;^UTILITY(U,$J,.84,8165,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8165,5,1,0)
 ;;=DIWE4^HD
 ;;^UTILITY(U,$J,.84,8170,0)
 ;;=8170^2^^2
 ;;^UTILITY(U,$J,.84,8170,2,0)
 ;;=^^1^1^2991027^
 ;;^UTILITY(U,$J,.84,8170,2,1,0)
 ;;=Select ALTERNATE EDITOR: 
 ;;^UTILITY(U,$J,.84,8170,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8170,5,1,0)
 ;;=DIWE12^ASK
 ;;^UTILITY(U,$J,.84,8171,0)
 ;;=8171^3^^2
 ;;^UTILITY(U,$J,.84,8171,2,0)
 ;;=^^1^1^2991027^
 ;;^UTILITY(U,$J,.84,8171,2,1,0)
 ;;=Choose an Alternate Editor
 ;;^UTILITY(U,$J,.84,8171,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8171,5,1,0)
 ;;=DIWE12^ASK+5
 ;;^UTILITY(U,$J,.84,8172,0)
 ;;=8172^3^^2
 ;;^UTILITY(U,$J,.84,8172,2,0)
 ;;=^^1^1^2991027^
 ;;^UTILITY(U,$J,.84,8172,2,1,0)
 ;;=  from the following:
 ;;^UTILITY(U,$J,.84,8172,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8172,5,1,0)
 ;;=DIWE12^ASK+6
 ;;^UTILITY(U,$J,.84,8175,0)
 ;;=8175^2^^2
 ;;^UTILITY(U,$J,.84,8175,2,0)
 ;;=^^1^1^2991027^
 ;;^UTILITY(U,$J,.84,8175,2,1,0)
 ;;=Edit
 ;;^UTILITY(U,$J,.84,8175,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8175,5,1,0)
 ;;=DIWE12^E
 ;;^UTILITY(U,$J,.84,8176,0)
 ;;=8176^3^^2
 ;;^UTILITY(U,$J,.84,8176,2,0)
 ;;=^^2^2^2991027^
 ;;^UTILITY(U,$J,.84,8176,2,1,0)
 ;;=    Enter 'YES' if you wish to go into the editor.
 ;;^UTILITY(U,$J,.84,8176,2,2,0)
 ;;=    Enter 'NO' if you do not wish to edit at this time.
 ;;^UTILITY(U,$J,.84,8176,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8176,5,1,0)
 ;;=DIWE12^E
 ;;^UTILITY(U,$J,.84,8179,0)
 ;;=8179^3^^2
 ;;^UTILITY(U,$J,.84,8179,2,0)
 ;;=^^1^1^2991121^
 ;;^UTILITY(U,$J,.84,8179,2,1,0)
 ;;=PRESS <Enter> to edit the WORD-PROCESSING field
 ;;^UTILITY(U,$J,.84,8179,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8179,5,1,0)
 ;;=DDSWP^EGP
 ;;^UTILITY(U,$J,.84,8180,0)
 ;;=8180^2^^2
 ;;^UTILITY(U,$J,.84,8180,2,0)
 ;;=^^1^1^2991027^^^
 ;;^UTILITY(U,$J,.84,8180,2,1,0)
 ;;=NUMBER OF COPIES: 
 ;;^UTILITY(U,$J,.84,8180,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8180,5,1,0)
 ;;=DIP3^SDP+1
 ;;^UTILITY(U,$J,.84,8181,0)
 ;;=8181^2^^2
 ;;^UTILITY(U,$J,.84,8181,2,0)
 ;;=^^1^1^2991027^^
 ;;^UTILITY(U,$J,.84,8181,2,1,0)
 ;;=OUTPUT COPIES TO WHAT DEVICE: 
 ;;^UTILITY(U,$J,.84,8181,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8181,5,1,0)
 ;;=DIP3^O
 ;;^UTILITY(U,$J,.84,8190,0)
 ;;=8190^2^y^2
 ;;^UTILITY(U,$J,.84,8190,2,0)
 ;;=^^1^1^2991027^
 ;;^UTILITY(U,$J,.84,8190,2,1,0)
 ;;=MARGIN WIDTH IS NORMALLY AT LEAST |1|...    ARE YOU SURE
 ;;^UTILITY(U,$J,.84,8190,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8190,3,1,0)
 ;;=1^MARGIN WIDTH KNOWN BY THE PRINT TEMPLATE
 ;;^UTILITY(U,$J,.84,8190,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8190,5,1,0)
 ;;=DIP3^FREE+1
 ;;^UTILITY(U,$J,.84,8191,0)
 ;;=8191^2^^2
 ;;^UTILITY(U,$J,.84,8191,2,0)
 ;;=^^1^1^2991027^^
 ;;^UTILITY(U,$J,.84,8191,2,1,0)
 ;;=Do you want to free up this Terminal
 ;;^UTILITY(U,$J,.84,8191,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8191,5,1,0)
 ;;=DIP3^FREE+2
 ;;^UTILITY(U,$J,.84,8192,0)
 ;;=8192^2^^2
 ;;^UTILITY(U,$J,.84,8192,2,0)
 ;;=^^1^1^2991027^
 ;;^UTILITY(U,$J,.84,8192,2,1,0)
 ;;=THIS TERMINAL IS NOW FREE!
 ;;^UTILITY(U,$J,.84,8192,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8192,5,1,0)
 ;;=DIP3^FREE+3
 ;;^UTILITY(U,$J,.84,8195,0)
 ;;=8195^2^^2
 ;;^UTILITY(U,$J,.84,8195,1,0)
 ;;=^^1^1^2990902^
 ;;^UTILITY(U,$J,.84,8195,1,1,0)
 ;;=one line only!
 ;;^UTILITY(U,$J,.84,8195,2,0)
 ;;=^^1^1^2990902^^
 ;;^UTILITY(U,$J,.84,8195,2,1,0)
 ;;=Do you always want to suppress subheaders when printing template
 ;;^UTILITY(U,$J,.84,8195,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8195,5,1,0)
 ;;=DIP21^SUB
 ;;^UTILITY(U,$J,.84,8196,0)
 ;;=8196^2^y^2
 ;;^UTILITY(U,$J,.84,8196,2,0)
 ;;=^^1^1^2990903^
 ;;^UTILITY(U,$J,.84,8196,2,1,0)
 ;;=Do you want to edit the '|1|' Template
 ;;^UTILITY(U,$J,.84,8196,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8196,3,1,0)
 ;;=1^NAME OF TEMPLATE
 ;;^UTILITY(U,$J,.84,8196,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8196,5,1,0)
 ;;=DIP21^EDIT
 ;;^UTILITY(U,$J,.84,8197,0)
 ;;=8197^2^^2
 ;;^UTILITY(U,$J,.84,8197,2,0)
 ;;=^^1^1^2990828^
 ;;^UTILITY(U,$J,.84,8197,2,1,0)
 ;;=Display Audit Trail
 ;;^UTILITY(U,$J,.84,8197,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8197,5,1,0)
 ;;=DII
 ;;^UTILITY(U,$J,.84,8197.1,0)
 ;;=8197.1^2^y^2
 ;;^UTILITY(U,$J,.84,8197.1,2,0)
 ;;=^^1^1^2991218^^
 ;;^UTILITY(U,$J,.84,8197.1,2,1,0)
 ;;=Deleted "|1|"
 ;;^UTILITY(U,$J,.84,8197.1,3,0)
 ;;=^.845^1^1
 ;;^UTILITY(U,$J,.84,8197.1,3,1,0)
 ;;=1^The deleted value of the field being displayed in CAPTIONED OUTPUT, according to the audit trail
 ;;^UTILITY(U,$J,.84,8197.1,5,0)
 ;;=^.841^1^1
 ;;^UTILITY(U,$J,.84,8197.1,5,1,0)
 ;;=DIQ^PRINTAUD+5
 ;;^UTILITY(U,$J,.84,8197.2,0)
 ;;=8197.2^2^y^2
 ;;^UTILITY(U,$J,.84,8197.2,2,0)
 ;;=^^1^1^2991218^
