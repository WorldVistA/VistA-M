GMPLUTL4 ; SLC/KER -- PL Utilities (Misc)           ; 04/15/2002
 ;;2.0;Problem List;**26**;Aug 25, 1994
 ;
 ; External References
 ;   DBIA 10096  ^%ZOSF("TEST")
 ;                       
 ; Variable Used but NEWed/KILLed Elsewhere
 ;   IOT, ORWINDEV 
 ;                    
PTR(X) ; Output to Printer
 ;   1 = Yes
 ;   0 = No
 Q:+($$VISTA)>0!(+($$HFP)>0) 1
 Q 0
 ;
VISTA(X) ; Vista Printer
 Q:$E($G(ION),1,3)="NUL" 0  Q:$G(IOT)'="HFS"&($E($G(IOST),1,2)["P-")&($G(IOST)'="P-OTHER") 1
 Q 0
 ;
HFP(X) ; Host File sent to Printer
 ;   Check ORWINDEV
 N GMTS85 S GMTS85=$$PROK("ORWRP",85)
 Q:+($G(GMTS85))>0&(+($G(ORWINDEV))>0) 1
 ;   Check Host File Server
 Q:$G(IOT)'="HFS" 0
 ;   Host File for GUI Scrollable Window
 Q:$E($G(ION),1,14)["OR WORKSTATION" 0
 ;   TCP/IP Printer
 Q:$G(IO)["$PRT"!($G(IO)["PRN|") 1
 ;   Windows Printer
 Q:$E($G(ION),1,14)["OR WINDOWS HFS" 1
 ;   Host Files (file or unspecifed printer)
 Q 0
 ;             
 ; Miscellaneous
PROK(X,Y) ; Routine and Patch # OK
 N GMTS,GMTSI,GMTSO S X=$G(X),Y=$G(Y) Q:'$L(X) 0 Q:Y'=""&(+Y=0)
 S Y=+Y,GMTS=$$ROK(X) Q:'GMTS 0 Q:+Y=0 1 S GMTSO=0,GMTS=$T(@("+2^"_X)),GMTS=$P($P(GMTS,"**",2),"**",1)
 F GMTSI=1:1:$L(GMTS,",") S:+($P(GMTS,",",GMTSI))=Y GMTSO=1 Q:GMTSO=1
 S X=GMTSO Q X
ROK(X) ; Routine OK (in UCI)
 S X=$G(X) Q:'$L(X) 0  Q:$L(X)>8 0  X ^%ZOSF("TEST") Q:$T 1  Q 0
