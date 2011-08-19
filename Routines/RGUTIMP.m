RGUTIMP ;CAIRO/DKM - Import text into FileMan file;04-Sep-1998 11:26;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
 ;=================================================================
 ; Imports data from a specially formatted text file into a
 ; FileMan file.
 ; Inputs:
 ;   RGINP  = Full input file or global specification.
 ;   RGTRACE= If nonzero, generates a debug trace.
 ; Outputs:
 ;   Returns status code^status message.  Status code of 0 means
 ;   successful completion.
 ;=================================================================
ENTRY(RGINP,RGTRACE) ;
 N RGLN,RGFN,RGLVL,RGBM,RGC,RGLBL,RGQT,RGST,RGIO,RGGBL
 S @$$TRAP^RGZOSF("ERROR^RGUTIMP")
 S RGFN=0,RGLVL=-1,RGTRACE=+$G(RGTRACE),RGST=0,RGIO=$I,U="^",RGC=0,RGGBL=$E(RGINP)=U
 I RGGBL S RGINP=$$CREF^DILF(RGINP)
 E  D OPEN^RGZOSF(.RGINP,"R")
 F  Q:$$READ  D  Q:RGST
 .U RGIO
 .W:RGTRACE=1 RGC,*13
 .W:RGTRACE=2 RGC_": ",$$TRUNC^RGUT(RGLN,$G(IOM,80)-$X-2),!
 .D DOIT(RGLN)
 D:'RGGBL CLOSE^RGZOSF(.RGINP)
 Q RGST
READ() I 'RGGBL S RGC=RGC+1 Q $$READ^RGZOSF(.RGLN,RGINP)
 S RGC=$O(@RGINP@(RGC))
 Q:'RGC 1
 I $D(@RGINP@(RGC))#2 S RGLN=@RGINP@(RGC) Q 0
 I $D(@RGINP@(RGC,0))#2 S RGLN=@RGINP@(RGC,0) Q 0
 Q 1
ERROR D ERR("Fatal error",$$EC^%ZOSV)
 Q RGST
DOIT(RGLN) ;
 N RGZ,RGL,RGFLD,RGWP
 S RGLN=$$TRIM^RGUT(RGLN)
 I ";"[$E(RGLN) W:RGTRACE=3 $P(RGLN,";",2,999),! Q
 F RGL=0:1 Q:$E(RGLN,RGL+1)'="."
 S RGLN=$E(RGLN,RGL+1,999)
 I RGLN'[":" D ERR("Missing label",RGLN) Q
 S RGLBL=$$TRIM^RGUT($P(RGLN,":")),RGLN=$$TRIM^RGUT($P(RGLN,":",2,999))
 I 'RGL S RGFN=$$FILE(RGLN) Q
 I RGL>RGLVL D ERR("Invalid nesting",RGLN) Q
 S RGLVL=RGL,RGFN=+$P(RGBM(RGLVL),U,4)
 S RGFLD=$$FLD(RGLBL,RGFN)
 S RGZ=+$P($G(^DD(RGFN,RGFLD,0)),U,2)
 I RGZ D  Q:RGST
 .S RGLVL=RGLVL+1,RGFN=RGZ,RGBM(RGLVL)=$$ENTRY^RGUTDIC(RGBM(RGLVL-1),"+"_RGFN)
 .I +RGBM(RGLVL)<0 D ERR("Error access subfile entry",RGLBL) Q
 .S RGFLD=$$FLD(.01,RGFN)
 I 'RGFLD D ERR("Unknown field",RGLBL) Q
 I 'RGWP,RGLN="" Q
 ;S:RGLN="+" RGLN=U_$TR($P(RGBM(RGLVL),U,2),"|",",")_"$C(1))",RGLN=1+$O(@RGLN,-1)\1
 I RGFLD=.01!'RGBM(RGLVL)!RGWP D  Q
 .I 'RGWP,RGFLD'=.01 D ERR("First field is not primary index",RGLBL) Q
 .I 'RGWP D
 ..S RGBM(RGLVL)=$$ENTRY^RGUTDIC(RGBM(RGLVL),"="_RGLN)
 ..S:+RGBM(RGLVL)'>0 RGBM(RGLVL)=$$ENTRY^RGUTDIC(RGBM(RGLVL),"="_$$UP^XLFSTR(RGLN))
 .S:+RGBM(RGLVL)'>0!RGWP RGBM(RGLVL)=$$ENTRY^RGUTDIC(RGBM(RGLVL),$S(RGLN="@"&'RGWP:RGLN,1:"~LX;.01///^S X=RGLN"))
 .I +RGBM(RGLVL)'>0,RGLN'="@" D ERR("Error adding entry",RGLN)
 S RGBM(RGLVL)=$$ENTRY^RGUTDIC(RGBM(RGLVL),"<;"_RGFLD_"///^S X=RGLN")
 D:+RGBM(RGLVL)'>0 ERR("Error writing to field",RGLBL)
 Q
FILE(RGFN) ;
 K RGBM
 S RGBM(1)=$$ENTRY^RGUTDIC(RGFN),RGLVL=1
 I +RGBM(1)'<0 S RGFN=+$P(RGBM(1),U,4)
 E  D ERR("Error accessing database",RGFN)
 Q RGFN
FLD(RGNM,RGFN) ;
 N RGZ
 S RGZ=$S(RGNM="":.01,RGNM=+RGNM:RGNM,1:+$O(^DD(RGFN,"B",RGNM,0)))
 I '$D(^DD(RGFN,RGZ,0)) S RGZ=0
 E  S RGWP=$P(^(0),U,2)["W"
 Q RGZ
ERR(RGMSG,RGX) ;
 S RGST=RGC_U_RGMSG_$S($D(RGX):": "_RGX,1:"")
 W:RGTRACE=2 RGC_": "_$P(RGST,U,2,999),!
 Q
