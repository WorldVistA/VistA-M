SCRPTPOS ;ALB/DJS - Team Position Extract for PCMMR Data Validation; 04/08/14
 ;;5.3;Scheduling;**620**;AUG 13, 1993;Build 11
 ;
ENTER ; Entry point
 ; 
 ; Extract file will be a delimited text file (.TXT) that will provide information for PCMM data validation
 ; Delimiter is a pipe ("|") character
 ;
 ; FILE OUTPUT:
 ;
 ; STANUM - Station #
 ; TPIEN - IEN of Team Position
 ; TPOS - Name of Team Position
 ; TIEN - IEN pointer to Team file #404.51
 ; TNAME - Team Name
 ; ROLEIEN - IEN of Standard Role
 ; ROLE - Standard Role Name
 ; POSSPP - Possible Primary Practitioner
 ; MAXPT - Max # of Patients
 ; PRECPOS - Preceptor Position
 ; ACTASPRE - Can act as a Preceptor?
 ; PDESC - Position Description
 ; DEATHMSG - Death Message 
 ; INPTMSG - Inpatient Message
 ; TEAMMSG - Team Message
 ; PREDTHMS - Preceptor Death Message
 ; PREINPMS - Preceptor Inpatient Message
 ; PRETMMSG - Preceptor Team Message
 ; AUINAMSG - Automatic Inactivation Message
 ; PRAINMSG - Preceptor Automatic Inactivation Message
 ; CURPCPT - Current # of PC Patients
 ; CURPTS - Current # of Patients
 ; CURSTAT - Current Status == Active or Inactive
 ; CUREFFDT - Current Effective Date
 ; CURACTDT - Current Activation Date
 ; CURINADT - Current Inactivation Date
 ; CURPRAC - Current Practitioner
 ; CURPRCPS - Current Preceptor Position
 ; CURPREC - Current Preceptor
 ; ACTPREC - Active Precepts
 ;
 N SCMCPATH,SCMCHFS,SCMCERR,SCMCMODE,MSG,IOF
 N SITE,SCDATA,SCIENS,STANUM,TPIEN,TPOS,TIEN,TNAME,ROLEIEN,ROLE,POSSPP,MAXPT,PRECPOS,ACTASPRE,PDESC,DEATHMSG,INPTMSG,TEAMMSG,PREDTHMS
 N PREINPMS,PRETMMSG,AUINAMSG,PRAINMSG,CURPCPT,CURPTS,CURSTAT,CUREFFDT,CURACTDT,CURINADT,CURPRAC,CURPRCPS,CURPREC,ACTPREC
 S SITE=$$SITE^VASITE,STANUM=$P(SITE,"^",3)
 S SCMCPATH=$$DEFDIR^%ZISH(),SCMCHFS=STANUM_"_PCMMTEAMPOSITION.TXT",SCMCERR=0 U 0 W !!,SCMCPATH
 D HFSOPEN("SCMCRP",SCMCPATH,SCMCHFS,"W") I SCMCERR G END
 U IO
 D COLHDR,SETREC G END
 ;
SETREC  ;$O through Team Position file and find all team positions
    S TPIEN=0
 F  S TPIEN=$O(^SCTM(404.57,TPIEN)) Q:TPIEN=""!(TPIEN'?.N)  D
 .K SCDATA
 .S SCIENS=+$G(TPIEN)_","
 .D GETS^DIQ(404.57,SCIENS,".01;.02;.03;.04;.08;.1;.12;1;2.01;2.02;2.03;2.05;2.06;2.07;2.09;2.10;200;201;300;301;302;303;304;305;306;307","IE","SCDATA","")
 .S TPOS=$G(SCDATA(404.57,SCIENS,.01,"E"))
 .S TIEN=$G(SCDATA(404.57,SCIENS,.02,"I"))
 .S TNAME=$G(SCDATA(404.57,SCIENS,.02,"E"))
 .S ROLEIEN=$G(SCDATA(404.57,SCIENS,.03,"I"))
 .S ROLE=$G(SCDATA(404.57,SCIENS,.03,"E"))
 .S POSSPP=$G(SCDATA(404.57,SCIENS,.04,"E"))
 .S MAXPT=$G(SCDATA(404.57,SCIENS,.08,"E"))
 .S PRECPOS=$G(SCDATA(404.57,SCIENS,.1,"E"))
 .S ACTASPRE=$G(SCDATA(404.57,SCIENS,.12,"E"))
 .S PDESC=$G(^SCTM(404.57,TPIEN,1,1,0))
 .S DEATHMSG=$G(SCDATA(404.57,SCIENS,2.01,"E"))
 .S INPTMSG=$G(SCDATA(404.57,SCIENS,2.02,"E"))
 .S TEAMMSG=$G(SCDATA(404.57,SCIENS,2.03,"E"))
 .S PREDTHMS=$G(SCDATA(404.57,SCIENS,2.05,"E"))
 .S PREINPMS=$G(SCDATA(404.57,SCIENS,2.06,"E"))
 .S PRETMMSG=$G(SCDATA(404.57,SCIENS,2.07,"E"))
 .S AUINAMSG=$G(SCDATA(404.57,SCIENS,2.09,"E"))
 .S PRAINMSG=$G(SCDATA(404.57,SCIENS,2.10,"E"))
 .S CURPCPT=$G(SCDATA(404.57,SCIENS,200,"E"))
 .S CURPTS=$G(SCDATA(404.57,SCIENS,201,"E"))
 .S CURSTAT=$G(SCDATA(404.57,SCIENS,300,"E"))
 .S CUREFFDT=$G(SCDATA(404.57,SCIENS,301,"E"))
 .S CURACTDT=$G(SCDATA(404.57,SCIENS,302,"E"))
 .S CURINADT=$G(SCDATA(404.57,SCIENS,303,"E"))
 .S CURPRAC=$G(SCDATA(404.57,SCIENS,304,"E"))
 .S CURPRCPS=$G(SCDATA(404.57,SCIENS,305,"E"))
 .S CURPREC=$G(SCDATA(404.57,SCIENS,306,"E"))
 .S ACTPREC=$G(SCDATA(404.57,SCIENS,307,"E"))
 .W STANUM_"|"_TPIEN_"|"_TPOS_"|"_TIEN_"|"_TNAME_"|"_ROLEIEN_"|"_ROLE_"|"_POSSPP_"|"_MAXPT_"|"_PRECPOS_"|"_ACTASPRE_"|"_PDESC_"|"_DEATHMSG_"|"_INPTMSG_"|"_TEAMMSG_"|"_PREDTHMS_"|"
 .W PREINPMS_"|"_PRETMMSG_"|"_AUINAMSG_"|"_PRAINMSG_"|"_CURPCPT_"|"_CURPTS_"|"_CURSTAT_"|"_CUREFFDT_"|"_CURACTDT_"|"_CURINADT_"|"_CURPRAC_"|"_CURPRCPS_"|"_CURPREC_"|"_ACTPREC,!
 Q
 ;
COLHDR ;Create column header for Team Position extract file
 W "Station #|Position IEN|Position Name|Team IEN|Team Name|Standard Role IEN|Standard Role Name|Possible Primary Practitioner|Max # Patients|Preceptor Position|Can Act as Preceptor|Position Description|"
 W "Death Message|Inpatient Message|Team Message|Preceptor Death Message|Preceptor Inpatient Message|Preceptor Team Message|Auto Inactivation Message|Prec Auto Inactivation Message|Current # PC Patients|"
 W "Current # Patients|Current Status|Current Effective Date|Current Activation Date|Current Inactivation Date|Current Practitioner|Current Preceptor Position|Current Preceptor|Active Precepts",!
 Q
 ;
END D HFSCLOSE("SCMCRP",SCMCHFS)
 N I
 I '+SCMCERR D  Q  ;Create pipe delimited output if no errors
 .S MSG=$NA(^TMP("SCMC",$J))
 ;Replace "##FFFF##" with Form Feeds - code needed for LINUX environments
 S I=0 F  S I=$O(^TMP("SCMC",$J,1,I)) Q:'I  D
 .S:^TMP("SCMC",$J,1,I)["##FFFF##" ^TMP("SCMC",$J,1,I)=$P(^TMP("SCMC",$J,1,I),"##FFFF##")_$C(13,12)_$P(^TMP("SCMC",$J,1,I),"##FFFF##",2)
 .S ^TMP("SCMC",$J,1,I)=^TMP("SCMC",$J,1,I)_$C(13)
 .S:^TMP("SCMC",$J,1,I)["$END" ^TMP("SCMC",$J,1,I)=""
 S MSG=$NA(^TMP("SCMC",$J))
 Q
 ;
HFSOPEN(HANDLE,SCMCPATH,SCMCHFS,SCMCMODE) ; Open File
 N POP
 D OPEN^%ZISH(HANDLE,SCMCPATH,SCMCHFS,$G(SCMCMODE,"W")) D:POP  Q:POP
 .S SCMCERR=1,^TMP("SCMC",$J,1)="0^Unable to open file "
 S IOF="$$IOF^SCRPTPOS"   ;resets screen position and adds page break flag - added to deal with Linux environments.
 Q
 ;
HFSCLOSE(HANDLE,SCMHFS) ;Close HFS and unload data
 D CLOSE^%ZISH(HANDLE)
 Q
 ;
IOF() ;used to reset position and insert page break flag when @IOF is executed.
 S $X=0,$Y=0
 Q "##FFFF##"_$C(13,10)
 ;
