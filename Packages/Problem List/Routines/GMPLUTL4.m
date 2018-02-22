GMPLUTL4 ; SLC/KER/TC -- PL Utilities (Misc) ;03/07/17  08:48
 ;;2.0;Problem List;**26,49**;Aug 25, 1994;Build 43
 ;
 ; External References
 ;   ICR  10066  XMZ^XMA2
 ;   ICR  10070  ENT1^XMD
 ;   DBIA 10096  ^%ZOSF("TEST")
 ;
 ; Variable Used but NEWed/KILLed Elsewhere
 ;   IOT, ORWINDEV
 ;
 ;=================================================
ASKYN(GMPLDEF,GMPLTEXT) ;
 N DIR,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="Y0"
 S DIR("A")=GMPLTEXT
 S DIR("B")=GMPLDEF
 S DIR("?")="Enter Y or N."
 W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) S Y=GMPLDEF
 Q Y
 ;
 ;============================================
GETEHF(GMPLEXT,GMPLDPTH) ;Get an existing host file.
 ;Build a list of all .EXT files in the current directory.
 N GMPLDEXT,DIR,DIROUT,DIRUT,DTOUT,DUOUT
 N GMPLFSPC,GMPLFLST,GMPLPATH,X,Y,GMPLFILE
 I GMPLEXT="" D
 . S DIR(0)="FAU"_U_"1:32"
 . S DIR("A")="Enter a file extension: "
 . S DIR("?")="A file specification has the format name.extension."
 . D ^DIR
 . S GMPLEXT=Y
 I $D(DIRUT) Q ""
 S GMPLDEXT="*."_GMPLEXT
 S GMPLFSPC(GMPLDEXT)=""
 S GMPLPATH=$S($G(GMPLDPTH)'="":GMPLDPTH,1:$$PWD^%ZISH)
 S DIR(0)="FAU"_U_"1:32"
 S DIR("A")="Enter a path: "
 S DIR("B")=GMPLPATH
 S DIR("?",1)="A host file is a file on your host system."
 S DIR("?",2)="A complete host file consists of a path, file name, and extension."
 S DIR("?",3)="A path consists of a device and directory name."
 I $G(GMPLEXT)'="" S DIR("?",4)="The default extension is "_GMPLEXT_"."
 S DIR("?")="The default path is "_GMPLPATH
 D ^DIR
 I $D(DIRUT) Q ""
 S GMPLPATH=Y
 S Y=$$LIST^%ZISH(GMPLPATH,"GMPLFSPC","GMPLFLST")
 I Y D
 . W !,"The following "_GMPLEXT_" files were found in ",GMPLPATH
 . S GMPLFILE=""
 . F  S GMPLFILE=$O(GMPLFLST(GMPLFILE)) Q:GMPLFILE=""  W !,?2,GMPLFILE
 E  W !,"No "_GMPLEXT_" files were found in path ",GMPLPATH
 ;
 K DIR,X,Y
 S DIR(0)="FAOU"_U_"1:32"
 S DIR("A")="Enter a file name: "
 S DIR("?",1)="A file name has the format NAME.EXTENSION, the default extension is "_GMPLEXT
 S DIR("?",2)="Therefore if you type in FILE for the file name, the host file will be"
 S DIR("?")="  "_GMPLPATH_"FILE."_GMPLEXT
 D ^DIR
 I $D(DIRUT) Q ""
 S GMPLFILE=Y
 ;Add the default extension if there isn't one.
 I GMPLFILE'["." S GMPLFILE=GMPLFILE_"."_GMPLEXT
 Q GMPLPATH_U_GMPLFILE
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
SEND(GMPLNODE,GMPLSUB,GMPLTO,GMPLFROM) ; Send a MailMan message whose text is in
 ;^TMP(GMPLNODE,$J,N,0). GMPLSUB is the subject. GMPLTO is the optional
 ;list of addresses, setup exactly like ;the MailMan XMY array.
 ;GMPLFROM is the optional message from, if it is not defined then from will be
 ;Problem List Support. This can be free text or a DUZ.
 ;
 N GMPLNL,XMDUZ,XMSUB,XMY,XMZ
 ;
 ;Make sure the subject does not exceed 64 characters.
 S XMSUB=$E(GMPLSUB,1,64)
 ;
 ;Make the default sender Problem List.
 S XMDUZ=$S($G(GMPLFROM)="":"Problem List Support",1:GMPLFROM)
 ;
RETRY ;Get the message number.
 D XMZ^XMA2
 I XMZ<1 G RETRY
 ;
 ;Load the message
 M ^XMB(3.9,XMZ,2)=^TMP(GMPLNODE,$J)
 K ^TMP(GMPLNODE,$J)
 S GMPLNL=$O(^XMB(3.9,XMZ,2,""),-1)
 S ^XMB(3.9,XMZ,2,0)="^3.92^"_+GMPLNL_U_+GMPLNL_U_DT
 ;
 ;Send message to TO list if it is defined.
 I $D(GMPLTO) M XMY=GMPLTO D ENT1^XMD Q
 ;
