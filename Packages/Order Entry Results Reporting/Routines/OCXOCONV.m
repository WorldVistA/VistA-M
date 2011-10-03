OCXOCONV ;SLC/RJS,CLA - EXPERT SYSTEM CONVERSION (PRE 1T13 -> 1T14) ;10/29/98  12:37
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
EN ;
 ;
 N OCXOETIM,OCXTOT,OCXCUR,OCXX,OCXY,OCXZ
 S OCXOETIM=$H
 ;
 I '$D(^OCX) D BMES^XPDUTL("  The ^OCX global is missing,  Conversion Aborted...") H 3 Q
 ;
 F OCXZ="^OCXS","^OCXD" I $D(@OCXZ) D
 .D BMES^XPDUTL("  Purging files in the "_OCXZ_" global...")
 .S OCXX=0 F  S OCXX=$O(@OCXZ@(OCXX)) Q:'OCXX  D
 ..I $D(@OCXZ@(OCXX)) S OCXY=$P(@OCXZ@(OCXX,0),U,1,2) K @OCXZ@(OCXX) S @OCXZ@(OCXX,0)=OCXY
 ;
 I $D(^OCX(10)) S OCXZ=$P(^OCX(10,0),U,1,2) D BMES^XPDUTL("  Purging the "_$P(OCXZ,U,1)_" file...") K ^OCX(10) S ^OCX(10,0)=OCXZ
 ;
 D BMES^XPDUTL("  Initializing scan, One moment please...")
 S OCXQUIT=0,GLREF="^OCX" F OCXTOT=0:1 S GLREF=$Q(@GLREF)  Q:'$L(GLREF)
 D BMES^XPDUTL("  Scanning ^OCX global for ^OCX( references...")
 S OCXQUIT=0,GLREF="^OCX" F OCXCUR=0:1 S GLREF=$Q(@GLREF)  Q:'$L(GLREF)  D  Q:OCXQUIT
 .D:'(OCXCUR#10) STATUS(OCXCUR,OCXTOT)
 .N GLVAL,DELIM
 .S GLVAL=@GLREF
 .Q:'(GLVAL["^OCX(")
 .S GLVAL=$$CONV(GLVAL)
 .S @GLREF=GLVAL
 ;
 D STATUS(10,10)
 H 1
 D STATUS(0,10)
 ;
 D BMES^XPDUTL("  Seperating ^OCX into ^OCXD and ^OCXS...")
 D BMES^XPDUTL("       ^OCXD contains the 'Dynamic' files likely to shrink and grow...")
 D BMES^XPDUTL("       ^OCXS contains the 'Static' files likely to remain the same size...")
 D BMES^XPDUTL("  Initializing, One moment please...")
 S OCXZ=0 F OCXTOT=0:1 S OCXZ=$O(^OCX(OCXZ)) Q:'OCXZ
 D BMES^XPDUTL("  Scanning ^OCX global moving files")
 S OCXZ=0 F OCXCUR=0:1 S OCXZ=$O(^OCX(OCXZ)) Q:'OCXZ  D
 .N NEWREF,OLDREF
 .S OLDREF="^OCX("_OCXZ_")"
 .S NEWREF=$$CONV("^OCX("_OCXZ)_")"
 .M @NEWREF=@OLDREF
 .D STATUS(OCXCUR,OCXTOT)
 ;
 D STATUS(10,10)
 H 1
 D STATUS(0,10)
 ;
 Q
CONV(V) ;
 F  Q:'(V["^OCX(")  D
 .N FILE,GL,NFILE
 .S FILE=+$P($P(V,"^OCX(",2),",",1)
 .;W !,"FILE:  ",FILE
 .S GL="^OCXS("
 .S:(FILE=1) GL="^OCXD("
 .S:(FILE=7) GL="^OCXD("
 .S:(FILE=10) GL="^OCXD("
 .S:(FILE="""LOG""") GL="^OCXD("
 .S NFILE=0
 .S:FILE NFILE=FILE/10+860 S:(FILE="""LOG""") NFILE=861
 .I 'NFILE Q
 .S V=$P(V,"^OCX("_FILE,1)_GL_NFILE_$P(V,"^OCX("_FILE,2,999)
 ;
 Q V
 ;
DATE() N X,Y,%DT S X="N",%DT="T" D ^%DT X ^DD("DD") Q Y
 ;
DTCONV(Y) Q:'(Y["@") Y Q $P(Y,"@",1)_" at "_$P(Y,"@",2,99)
 ;
STATUS(CURRENT,XPDIDTOT) ;
 ;
 I '$D(XPDIDVT) N XPDIDVT
 S XPDIDVT=$G(XPDIDVT)
 D UPDATE^XPDID(CURRENT)
 ;
 Q
 ;
