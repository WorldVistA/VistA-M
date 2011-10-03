GMTSU ; SLC/JER,KER/NDBI - Health Summary Utilities ; 08/27/2002
 ;;2.7;Health Summary;**27,28,31,35,37,43,47,56**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA 10096  ^%ZOSF("TEST")
 ;   DBIA  2934  ^A7RCP (NDBI Global)
 ;   DBIA 10103  $$FMTE^XLFDT
 ;   DBIA 10103  $$FMTHL7^XLFDT
 ;   DBIA 10103  $$HL7TFM^XLFDT
 ;   DBIA 10061  OERR^VADPT
 ;   DBIA 10104  $$UP^XLFSTR
 ;   DBIA 10026  ^DIR
 ;   DBIA  2052  FILE^DID
 ;   DBIA 10022  %XY^%RCR
 ;   DBIA  2055  $$VFIELD^DILFD
 ;   DBIA  2052  $$GET1^DID
 ;                              
PROK(X,Y) ; Routine and Patch # OK (in UCI)
 N GMTS,GMTSI,GMTSO S X=$G(X),Y=$G(Y) Q:'$L(X) 0 Q:Y'=""&(+Y=0)
 S Y=+Y,GMTS=$$ROK(X) Q:'GMTS 0 Q:+Y=0 1 S GMTSO=0,GMTS=$T(@("+2^"_X)),GMTS=$P($P(GMTS,"**",2),"**",1)
 F GMTSI=1:1:$L(GMTS,",") S:+($P(GMTS,",",GMTSI))=Y GMTSO=1 Q:GMTSO=1
 S X=GMTSO Q X
ROK(X) ; Routine OK (in UCI) (NDBI)
 S X=$G(X) Q:'$L(X) 0  Q:$L(X)>8 0  X ^%ZOSF("TEST") Q:$T 1  Q 0
NDBI(X) ; National Database Integration site 1 = yes  0 = no
 N R,G S X="A7RDUP" X ^%ZOSF("TEST") S R=$T,G=$S($D(^A7RCP):1,1:0),X=R+G,X=$S(X=2:1,1:0) Q X
 ;                
CPT(X) ; Use CPT Modifiers  Needs GMTSEG Array
 S X=+($G(X)) N GMTSN,GMTSC,GMTSM,GMTSA,GMTSI S GMTSN=$G(GMTSEG(X)) S GMTSC=+($P(GMTSN,"^",2)) Q:'GMTSC 0
 S GMTSM=$S($P(GMTSN,"^",9)="N":0,$P(GMTSN,"^",9)="":1,1:1) Q:'GMTSM 0
 S GMTSA=$S(+($$CMU(+GMTSC))>0:1,1:0) Q:'GMTSA 0
 Q 1
CMU(X) ; Component Uses CPT Modifiers
 N GMTSA,GMTSN,GMTSI S X=$G(X) Q:'$L(X) 0 S GMTSI=+X,GMTSA=$O(^GMT(142.1,"C",X,0)),GMTSN=$O(^GMT(142.1,"D",X,0)) S:GMTSI=0&(+GMTSA>0) GMTSI=GMTSA S:GMTSI=0&(+GMTSN>0) GMTSI=GMTSN
 Q:+GMTSI=0 0 S GMTSA=$S($P($G(^GMT(142.1,+GMTSI,0)),"^",14)="Y":1,1:0) Q:'GMTSA 0
 Q 1
 ;            
 ; Dates and Time
ED(X) ;   Health Summary External Date
 S X=$G(X) Q:'$L(X) ""  D REGDT4 Q X
EDT(X) ;   Health Summary External Date and Time
 S X=$G(X) Q:'$L(X) ""  D REGDTM4 Q X
REGDT ;   Receives X FM date and returns X in MM/DD/YY format
 S X=$TR($$FMTE^XLFDT(X,"2DZ"),"@"," ") Q
REGDT4 ;   Receives X FM date and returns X in MM/DD/YYYY format
 S X=$TR($$FMTE^XLFDT(X,"5DZ"),"@"," ") Q
REGDTM ;   Receives X FM date and returns X in MM/DD/YY TT:TT
 S X=$TR($$FMTE^XLFDT(X,"2ZM"),"@"," ") Q
REGDTM4 ;   Receives X FM date and returns X in MM/DD/YYYY TT:TT
 S X=$TR($$FMTE^XLFDT(X,"5ZM"),"@"," ") Q
SIDT ;   Receives X FM date and returns X in DD MMM YY
 N MON,MM S X=$P(X,".") S:'X X="" Q:'$L(X)
 S MON="JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC"
 S MM=$E(X,4,5),MM=$S(MM:$P(MON,U,+MM),1:"")
 S X=$E(X,6,7)_" "_MM_" "_$E(X,2,3) Q
MTIM ;   Convert Time from X=2890313.1304 to X=13:04
 S X=$P(X,".",2) Q:'$L(X)  S X=$S(X:$E(X,1,2)_$E("00",0,2-$L($E(X,1,2)))_":"_$E(X,3,4)_$E("00",0,2-$L($E(X,3,4))),1:"")
 Q
 ;            
HF(X) ; Host File - Used to distinguish from Host Files that
 ; are intended for Printers and Host Files for other
 ; purposes (windows/files)
 ;                
 ;   1 - if Device Type is HFS and not a TCP/IP Printer
 ;   0 - if Device Type is not HFS or device is a Printer
 ;            
 ; Check Device
 ;   Check Host File Server
 Q:$G(IOT)'="HFS" 0
 ;   Check ORWINDEV (Post OR*3.0*85)
 N GMTS85 S GMTS85=$$PROK("ORWRP",85)
 Q:+($G(GMTS85))>0&(+($G(ORWINDEV))>0) 0
 ;   Host File for GUI Scrollable Window
 Q:$E($G(ION),1,14)["OR WORKSTATION" 1
 ;   TCP/IP Printer
 Q:$G(IO)["$PRT"!($G(IO)["PRN|") 0
 ;   Windows Printer
 Q:$E($G(ION),1,14)["OR WINDOWS HFS" 0
 ;   Host Files (file or unspecifed printer)
 S X=0 S:$G(ION)["HOST FILE" X=1
 S:$E($G(IOST),1,5)["P-OTH" X=1
 Q X
 ;            
FMHL7DTM ; Convert X - int date/time to HL7 CCYYMMDDHHMM-HHHH
 S X=$$FMTHL7^XLFDT(+($G(X))) Q
HL7FMDTM ; Convert X - HL7 CCYYMMDDHHMM-HHHH to int date/time local
 S X=$$HL7TFM^XLFDT($G(X),"L") Q
 ;            
DEM ; Gets Demographic Data from VADPT
 ;            
 ;    Input    DFN
 ;            
 ;    Output   GMTSPNM     Patient Name
 ;             GMTSSN      Social Security Number
 ;             GMTSDOB     Date of Birth
 ;             SEX         Sex
 ;             GMTSWARD    Ward
 ;             GMTSRB      Bed
 ;             GMTSAGE     Age
 ;             VADM()      Demographic Array
 ;             VAIN()      Inpatient Array
 ;             GMTSPHDR()  Report Header Array
 ;            
 K VAHOW D OERR^VADPT S GMTSPNM=VADM(1),GMTSSN=$S($D(VA("PID")):VA("PID"),1:$P(VADM(2),"^",2))
 S GMTSAGE=$S(+VADM(4)>0:+VADM(4),1:99),SEX=$P(VADM(5),"^")
 S GMTSWARD=$P(VAIN(4),"^",2),GMTSRB=VAIN(5)
 S X=$P(VADM(3),"^") D REGDT4 S GMTSDOB=X K VA,GMTSPHDR N DOB,LWARDRB,NMSSN,NMSSNE,WARDRB,WARDRBE,WARDRBS
 S NMSSN=GMTSPNM_"    "_GMTSSN,NMSSNE=$L(NMSSN)+2,WARDRB=GMTSWARD_" "_GMTSRB
 S LWARDRB=$L(WARDRB),WARDRBS=40-(LWARDRB/2),WARDRBE=WARDRBS+LWARDRB
 S DOB="DOB: "_GMTSDOB,GMTSPHDR("NMSSN")=NMSSN,GMTSPHDR("WARDRB")=WARDRB
 S GMTSPHDR("WARDRBS")=WARDRBS,GMTSPHDR("DOB")=DOB,GMTSPHDR("DOBS")=64
 I (NMSSNE'<WARDRBS)!(WARDRBE'<64) S GMTSPHDR("TWO")=1
 Q
 ;                 
NAME(X,Y,L) ; Format name
 ;            
 ; Input 
 ;    X    Internal Entry Number of NEW PERSON file 200
 ;    Y    Flag to specify the first name format
 ;            0 for First Name Initial (only)
 ;            1 for First Name
 ;    L    Maximum Length of Name
 ;          
 ; Output  Last,First (name/initial) to specified length
 ;            
 N RAWNM,LAST,FIRST,ALPHA,PSN,CH,IEN,FNF,LEN
 S IEN=+($G(X)),FNF=+($G(Y)),LEN=+($G(L))
 S RAWNM=$$UNAM^GMTSU2(+IEN) S:LEN=0 LEN=$L(RAWNM)
 S RAWNM=$S($L(RAWNM):RAWNM,1:"UNKNOWN")
 S LAST=$P(RAWNM,","),FIRST=$P(RAWNM,",",2),ALPHA=0
 I $L(FIRST) D
 . F PSN=1:1 S CH=$E(FIRST,PSN) Q:CH=""  S:CH?1A ALPHA=PSN Q:ALPHA>0
 S:ALPHA>0 FIRST=$E(FIRST,ALPHA,$L(FIRST))
 S:'FNF FIRST=$E(FIRST,1)
 S X=$S($L(FIRST):LAST_","_FIRST,1:LAST),X=$E(X,1,LEN)
 Q X
GETRANGE(FROMDATE,TODATE) ; Select Date Range (from and to dates)
 N DIR,X,Y,DTOUT,DIRUT S DIR(0)="DO^:DT",DIR("A")="Enter Beginning Date (MM/DD/YY)" W !
 D ^DIR I $D(DIROUT)!$D(DUOUT)!$D(DTOUT)!$D(DIRUT) W ! Q
 S FROMDATE=Y I +FROMDATE>0 D
 . W "  (",$$UP^XLFSTR($$FMTE^XLFDT(+FROMDATE,1)),")"
 . N DIR,X,Y S DIR(0)="DO^::EX",DIR("A")="Enter Ending Date (MM/DD/YY)" S DIR("B")="TODAY"
 . D ^DIR I $D(DIROUT)!$D(DUOUT)!$D(DTOUT)!$D(DIRUT) K FROMDATE Q
 . I Y'>0 K FROMDATE Q
 . S TODATE=Y Q:TODATE>FROMDATE!(TODATE=FROMDATE) 
 . N FRDT S FRDT=FROMDATE,FROMDATE=TODATE,TODATE=FRDT
 W !
 Q
 ;                
OED() ; Other Editor - DIC("S")
 N COMP,OTHER,OWNER,OWNN,USER,AUSER,NAT S COMP=+($G(DA(1))) Q:'$D(^GMT(142,+COMP,0)) 0
 S OWNER=$P($G(^GMT(142,+COMP,0)),"^",3),OWNN=$$UNAM^GMTSU2(OWNER),NAT=+($P($G(^GMT(142,+COMP,"VA")),"^",1)),USER=+($G(DUZ)),AUSER=$$UACT^GMTSU2(+USER),OTHER=+($G(X))
 ;   If National Component and Uneditable
 W:+NAT=2 !!,"  Nationally exported Health Summary Type (uneditable)",! Q:+NAT=2 0
 ;   If OWNER is special case (national, uneditable)
 W:+OWNER>0&(OWNER<1)&(NAT'=1) !!,"  OWNER does not allow 'OTHER EDITORS'",! Q:+OWNER>0&(OWNER<1)&(NAT'=1) 0
 ;   If OWNER is special case (national, editable)
 Q:+OWNER>0&(OWNER<1)&(OWNER=USER)&(NAT=1) 1
 ;   If DUZ is inactive, or not the owner, quit
 W:+AUSER=0!(+OWNER=0)!(+OWNER'=+USER) !!,"  Only the OWNER may assign 'OTHER EDITORS'",! Q:+AUSER=0!(+OWNER=0)!(+OWNER'=+USER) 0
 ;   If OTHER is inactive user, quit
 S AUSER=$$UACT^GMTSU2(OTHER) W:+AUSER=0!(+OTHER'>.999999999) !!,"  Selected 'OTHER EDITOR' is not an active user",! Q:+AUSER=0!(+OTHER'>.999999999) 0
 ;   If OTHER=OWNER, quit
 W:+OTHER=+OWNER !!,"  ",OWNN," is the OWNER",! Q:+OTHER=+OWNER 0
 Q 1
 ;                
FCLR(X) ; File Closed Root
 S X=$G(X) Q:+X=0 "" N GMTSL S GMTSL=$$FLOC(X),X=$S($E(GMTSL,$L(GMTSL))=",":$P(GMTSL,",")_")",1:$E(GMTSL,1,$L(GMTSL)-1)) Q:'$L(X) "" S:'$D(@X) X=""
 Q X
FSFN(X) ; File/Sub-File Name
 N FI,FR,%X,%Y S FI=$G(X) Q:+X=0 "" N DIERR,GMTSN,GMTSE D FILE^DID(+FI,"N","NAME","GMTSN","GMTSE")
 S X="" S:'$D(DIERR) X=$$UP^XLFSTR($G(GMTSN("NAME"))) Q:$L(X) X
 K FR S %X="^DD("_+($G(FI))_",0,""NM"",",%Y="FR(" D %XY^%RCR S X=$$UP^XLFSTR($O(FR(""))) S:+X>0 X="" S:$L(X) X=X_" SUB-FILE" Q X
FNAM(X) ; File Name
 S X=$G(X) Q:+X=0 "" N DIERR,GMTSN,GMTSE D FILE^DID(+X,"N","NAME","GMTSN","GMTSE") S X="" S:'$D(DIERR) X=$G(GMTSN("NAME")) Q X
FLOC(X) ; File location
 S X=$G(X) Q:+X=0 "" N DIERR,GMTSN,GMTSE D FILE^DID(+X,"N","GLOBAL NAME","GMTSN","GMTSE") S X="" S:'$D(DIERR) X=$G(GMTSN("GLOBAL NAME")) Q X
FHDD(X) ; File has a DD?
 S X=+($G(X)) Q:+($G(X))=0 0 S X=$$VFIELD^DILFD(X,.01),X=$S($L(X):1,1:0) Q X
FLDN(X,Y) ; Field Name
 Q:+($G(X))=0!(+($G(Y))=0) "" S X=$$GET1^DID(+($G(X)),+($G(Y)),,"LABEL") Q X
FLDS(X,Y) ; Field Set of Codes
 Q:+($G(X))=0!(+($G(Y))=0) "" Q:$$GET1^DID(+($G(X)),+($G(Y)),,"TYPE")'="SET" "" S X=$$GET1^DID(+($G(X)),+($G(Y)),,"POINTER") Q X
FLDI(X,Y) ; Field Input Transform
 Q:+($G(X))=0!(+($G(Y))=0) "" S X=$$GET1^DID(+($G(X)),+($G(Y)),,"INPUT TRANSFORM") Q X
