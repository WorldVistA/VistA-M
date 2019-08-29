ORAMP505 ;HPS/DM - Post Installation Tasks ; 3/12/19 9:24am
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**505**;Dec 17, 1997;Build 1
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine uses the following IAs:
 ; #10141 - MES^XPDUTL Kernel (supported)
 ; #10141 - BMES^XPDUTL Kernel (supported)
 ; #2263 - EN^XPAR Kernel (supported)
 ;
 Q
EN ;
 ; Installing commands in the command file...
 D MES^XPDUTL("OR*3.0*505 Post install starting....")
 ;
 D MES^XPDUTL("Updating parameters...")
 ; Update ORAM GUI VERSION with new build number for AntiCoagulate.exe.
 D EN^XPAR("SYS","ORAM GUI VERSION",,"1.0.505.1")
 D MES^XPDUTL("Parameters updated.")
 ;
 D MES^XPDUTL("Stripping control characters from file ORAM(103)...")
 D STRPCCHR
 ;
 D MES^XPDUTL("OR*3.0*505 Post Init complete")
 ;
 Q
STRPCCHR ; This routine will strip out control characters from file #103
 N ORGLB,ORSTR,ORCHR,ORCNTRL,ORDONE,ORI,ORCNT,ORMSG
 S ORCNT=0,ORCNTRL=$C(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31)
 S ^XTMP("ORPS505",0)=$$FMADD^XLFDT(DT,730)_U_DT
 ; query through all nodes of file #103 - quit when xref encountered
 S ORGLB="^ORAM(103)"
 F  S ORGLB=$Q(@ORGLB) Q:($P(ORGLB,",",2)="B")!(ORGLB="")  D
 . ; skip 0 node (no word processing fields)
 . I $P(ORGLB,",",3)=0 Q
 . ; skip 6 node (no word processing fields)
 . I $P(ORGLB,",",3)=6
 . S ORSTR=@ORGLB,ORI=0
 . ; translate out all characters below ascii 32
 . S ORDONE=0
 . S ORI=0 F  S ORI=ORI+1 Q:ORI>$L(ORSTR)!ORDONE  S ORCHR=$E(ORSTR,ORI) I $A(ORCHR)<32 S ORSTR=$TR(ORSTR,ORCNTRL),ORDONE=1
 . ; if any characters have been stripped out then save old string and reset glb to new string
 . I $L(ORSTR)'=$L(@ORGLB) D
 . . S ORCNT=ORCNT+1
 . . S ^XTMP("ORPS505",ORGLB)=@ORGLB
 . . S @ORGLB=ORSTR
 . . Q
 . Q
 I 'ORCNT S ORMSG="No control characters found during scan of ORAM FLOWSHEET (#103)"
 E  S ORMSG="Control characters were removed from "_ORCNT_" records in ORAM FLOWSHEET (#103)"
 D BMES^XPDUTL(ORMSG)
 D MES^XPDUTL("")
 Q
