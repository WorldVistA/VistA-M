PXVRPC9 ;BPFO/LMT - PCE RPCs for Imm Disclosures ;06/21/16  16:08
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**216**;Aug 12, 1996;Build 11
 ;
 ;
SETDIS(PXRSLT,PXVIMM,PXAGENCY,PXDT,PXTMZONE) ;
 ;
 ; Save immunization disclosure information.
 ;
 ;Input:
 ;    PXRSLT - Return value passed by reference (Required)
 ;    PXVIMM - V Immunization IEN (Required)
 ;  PXAGENCY - Agency Name this record was disclosed to (Required)
 ;      PXDT - Date/Time this record was disclosed (Required)
 ;  PXTMZONE - Time Zone of the Date/Time (Required)
 ;
 ;Returns:
 ;   0^error message - If we could not save the disclosure information (either the RPC was called
 ;                     incorrectly, or the V Immunization IEN did not exist).
 ;   1               - Successfully saved the disclosure information
 ;   2^error message - We attempted to save the disclosure information, but encountered an error
 ;                     when filing the data to the database.
 ;
 N PXDTI,PXERR,PXFDA,PXFDAIEN,PXFILE,PXFILESUB,PXHR,PXIEN,PXIENS,PXMIN
 ;
 S PXRSLT="0"
 ;
 I '$G(PXVIMM) D  Q
 . S PXRSLT="0^V Immunization IEN is not valid"
 I $G(PXAGENCY)="" D  Q
 . S PXRSLT="0^Agency is not valid"
 I '$G(PXDT) D  Q
 . S PXRSLT="0^Date/Time is not valid"
 D DT^DILF("TX",$G(PXDT),.PXDTI)
 I $G(PXDTI)'>0 D  Q
 . S PXRSLT="0^Date/Time is not valid"
 I $G(PXTMZONE)="" D  Q
 . S PXRSLT="0^Time zone is not valid"
 I PXTMZONE?3A,$$GMTDIFF^XMXUTIL1(PXTMZONE)="" D  Q
 . S PXRSLT="0^Time zone is not valid"
 I PXTMZONE'?3A,PXTMZONE'?1(1"-",1"+")4N D  Q
 . S PXRSLT="0^Time zone is not valid"
 ;
 S PXIEN=+PXVIMM
 S PXFILE=$E(PXVIMM,$L(PXVIMM))
 S PXFILE=$S(PXFILE="D":9000080.11,1:9000010.11)
 ; maybe it was deleted after we sent it to DAS
 I PXFILE=9000010.11,'$D(^AUPNVIMM(PXIEN,0)) S PXFILE=9000080.11
 I PXFILE=9000080.11,'$D(^AUPDVIMM(PXIEN,0)) D  Q
 . S PXRSLT="0^V Immunization IEN does not exist"
 S PXAGENCY=$$AGENCY(PXAGENCY)
 I 'PXAGENCY D  Q
 . S PXRSLT="0^"_$P(PXAGENCY,U,2)
 S PXAGENCY=+PXAGENCY
 ;
 ; Update date/time, based off timezone differences
 D ZONEDIFF^XMXUTIL1(PXTMZONE,.PXHR,.PXMIN)
 S PXDTI=$$FMADD^XLFDT(PXDTI,,PXHR,PXMIN)
 ;
 S PXFILESUB=9000010.1182
 I PXFILE=9000080.11 S PXFILESUB=9000080.1182
 S PXIENS="+1,"_PXIEN_","
 S PXFDA(1,PXFILESUB,PXIENS,.01)=PXAGENCY
 S PXFDA(1,PXFILESUB,PXIENS,.02)=PXDTI
 D UPDATE^DIE("","PXFDA(1)","PXFDAIEN","PXERR")
 I $G(PXFDAIEN(1))>0 D  Q
 . S PXRSLT=1
 ;
 S PXRSLT="2^"_$G(PXERR("DIERR",1,"TEXT",1))
 Q
 ;
AGENCY(PXNAME) ;Get IEN of agency; allow LAYGO
 ;
 N PXERR,PXFDA,PXFDAIEN,PXIEN
 ;
 S PXFDA(1,920.71,"?+1,",.01)=PXNAME
 D UPDATE^DIE("E","PXFDA(1)","PXFDAIEN","PXERR")
 S PXIEN=$G(PXFDAIEN(1))
 I PXIEN>0 Q PXIEN
 Q "0^"_$G(PXERR("DIERR",1,"TEXT",1))
