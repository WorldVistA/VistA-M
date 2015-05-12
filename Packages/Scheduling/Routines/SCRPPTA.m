SCRPPTA ;ALB/DJS - Patient Team Assignment Extract for PCMMR Data Validation; 04/03/14
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
 ; PTAIEN - IEN of Patient Team Assigment
 ; PTIEN - IEN of Patient
 ; PTNAME - Patient Name
 ; PTDOB - Patient Date of Birth
 ; PTSSN - Patient SSN
 ; PTDOD - Patient Date of Death
 ; PTICN - Patient ICN
 ; ICNCHKSM - ICN Checksum
 ; LOCALICN - Locally Assigned ICN
 ; TMASGDT - Team Assigned Date
 ; TIEN - IEN of Team
 ; TANAME - Team  Assignment Name
 ; ASGNTYPE - IEN of Assignment Type
 ; DISCHDT - Team Discharge Date
 ; STATUS - Status
 ;
 N SCMCPATH,SCMCHFS,SCMCERR,SCMCMODE,MSG,IOF,SITE
 N SCDATA,SCIENS,PTDATA,PTIENS,STANUM,PTAIEN,PTIEN,PTNAME,PTDOB,PTSSN
 N PTDOD,PTICN,ICNCHKSM,LOCALICN,TMASGDT,TIEN,TANAME,ASGNTYPE,DISCHDT,STATUS
 S SITE=$$SITE^VASITE,STANUM=$P(SITE,"^",3)
 S SCMCPATH=$$DEFDIR^%ZISH(),SCMCHFS=STANUM_"_PCMMPATIENTTEAMASSIGNMENT.TXT",SCMCERR=0 U 0 W !!,SCMCPATH
 D HFSOPEN("SCMCRP",SCMCPATH,SCMCHFS,"W") I SCMCERR G END
 U IO
 D COLHDR,SETREC G END
 ;
SETREC  ;$O through the patient team assignment file
 S PTAIEN=0
 F  S PTAIEN=$O(^SCPT(404.42,PTAIEN)) Q:PTAIEN=""!(PTAIEN'?.N)  D
 .K SCDATA,PTDATA
 .S SCIENS=+$G(PTAIEN)_","
 .D GETS^DIQ(404.42,SCIENS,".01;.02;.03;.08;.09;.12;.14;.15","IE","SCDATA","")
 .S PTIEN=$G(SCDATA(404.42,SCIENS,.01,"I")) Q:PTIEN=""
 .S PTNAME=$G(SCDATA(404.42,SCIENS,.01,"E"))
 .S TMASGDT=$$FMTE^XLFDT($G(SCDATA(404.42,SCIENS,.02,"I"),"5D"))
 .S TIEN=$G(SCDATA(404.42,SCIENS,.03,"I"))
 .S TANAME=$G(SCDATA(404.42,SCIENS,.03,"E"))
 .S ASGNTYPE=$G(SCDATA(404.42,SCIENS,.08,"I"))
 .S DISCHDT=$$FMTE^XLFDT($G(SCDATA(404.42,SCIENS,.09,"I"),"5D"))
 .S STATUS=$G(SCDATA(404.42,SCIENS,.15,"E"))
 .S PTIENS=+$G(PTIEN)_","
 .D GETS^DIQ(2,PTIENS,".03;.09;.351;991.01;991.02;991.04","IE","PTDATA")
 .S PTDOB=$G(PTDATA(2,PTIENS,.03,"E"))
 .S PTSSN=$G(PTDATA(2,PTIENS,.09,"E"))
 .S PTDOD=$$FMTE^XLFDT($G(PTDATA(2,PTIENS,.351,"I"),"5D"))
 .S PTICN=$G(PTDATA(2,PTIENS,991.01,"E"))
 .S ICNCHKSM=$G(PTDATA(2,PTIENS,991.02,"E"))
 .S LOCALICN=$G(PTDATA(2,PTIENS,991.04,"E"))
 .W STANUM_"|"_PTAIEN_"|"_PTIEN_"|"_PTNAME_"|"_PTDOB_"|"_PTSSN_"|"_PTDOD_"|"_PTICN_"|"_ICNCHKSM_"|"_LOCALICN_"|"_TMASGDT_"|"_TIEN_"|"_TANAME_"|"_ASGNTYPE_"|"_DISCHDT_"|"_STATUS,!
 Q
 ;
COLHDR ;Create column header for Patient Team Assignment extract file
 W "Station #|Pt. Team Assign IEN|Patient IEN|Patient Name|Date of Birth|SSN|Date of Death|ICN|ICN Checksum|Locally Assigned ICN|Team Assigned Date|Team IEN|Team Assignment|Assignment Type|Team Discharge Date|Status",!
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
 S IOF="$$IOF^SCRPPTA"   ;resets screen position and adds page break flag - added to deal with Linux environments.
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
