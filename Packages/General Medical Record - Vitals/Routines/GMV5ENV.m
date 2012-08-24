GMV5ENV ;HIOFO/FT-GMRV*5*5 ENVIRONMENT CHECK ROUTINE ;11/23/04  11:21
 ;;5.0;GEN. MED. REC. - VITALS;**5**;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; #10048 - PACKAGE file (9.4)   (supported)
 ; #10141 - ^XPDUTL calls        (supported)
 ;
EN ; If FILE 9.4 entry is not "GEN. MED. REC. - VITALS", make it so.
 ; If more than one entry for package in FILE 9.4 and none are
 ; "GEN. MED. REC. - VITALS", then stop installation.
 ;
 N GMVARRAY,GMVCNT,GMVDA,GMVERR,GMVIEN,GMVLOOP,GMVMSG,GMVNAME,GMVNS,GMVOTHER,GMVYES
 S (GMVCNT,GMVOTHER(0),GMVYES)=0,GMVNS="GMRV"
 D FIND^DIC(9.4,"","","X",GMVNS,"","C","","","GMVARRAY","GMVERR")
 S GMVLOOP=0
 F  S GMVLOOP=$O(GMVARRAY("DILIST",1,GMVLOOP)) Q:GMVLOOP'>0!(GMVYES>0)  D
 .S GMVNAME=$G(GMVARRAY("DILIST",1,GMVLOOP)) Q:GMVNAME=""
 .I GMVNAME="GEN. MED. REC. - VITALS" D  Q  ;found the right entry
 ..S GMVYES=+$G(GMVARRAY("DILIST",2,GMVLOOP))
 ..Q
 .I GMVNAME'="GEN. MED. REC. - VITALS" D  Q  ;wrong name
 ..S GMVCNT=GMVCNT+1
 ..S GMVOTHER(0)=GMVCNT
 ..S GMVOTHER(GMVCNT)=+$G(GMVARRAY("DILIST",2,GMVLOOP))
 ..Q
 .Q
 Q:GMVYES  ;right entry found in FILE 9.4
 ; If only one entry in FILE 9.4 and it isn't "GEN. MED. REC. - VITALS",
 ; then change it.
 I GMVOTHER(0)=1 D  Q
 .S GMVIEN=+$G(GMVOTHER(1))
 .S GMVDA(9.4,GMVIEN_",",.01)="GEN. MED. REC. - VITALS"
 .D FILE^DIE("","GMVDA","GMVERR")
 .I $G(GMVERR) D  Q
 ..S GMVMSG="Could not change FILE 9.4 entry #"_GMVIEN_" to 'GEN. MED. REC. - VITALS'. Please log a NOIS."
 ..D BMES^XPDUTL(GMVMSG)
 ..S XPDQUIT=2 ;don't install patch, but leave in XTMP global
 ..Q
 .Q
 I GMVOTHER(0)>1 D
 .D BMES^XPDUTL("None of the FILE 9.4 entries have the correct name for the vitals package. Please log a NOIS.")
 .S XPDQUIT=2 ;don't install patch, but leave in XTMP global
 .Q
 Q
