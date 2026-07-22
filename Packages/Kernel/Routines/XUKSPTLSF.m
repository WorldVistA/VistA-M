XUKSPTLSF ;SLC/JLA - Kernel System Parameters TLS Form callback API's ; MAY 1, 2025@7:30
 ;;8.0;KERNEL;**787**;Jul 10, 1995;Build 73
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; FileMan/ScreenMan API's
 ;
FMDIE D ^DIE Q
GET1(AFILE,AIENS,AFIELD,AFLAGS,ATROOT,AMROOT) Q $$GET1^DIQ($G(AFILE),$G(AIENS),$G(AFIELD),$G(AFLAGS),$G(ATROOT),$G(AMROOT))
 ;
 ;
 ; TLS API's
 ;
 ; Get Kernal System Parameters TLS Configuration Name
GKSPTLSCN() Q $$GKSPTLSCN^XUTLS()
 ;
 ; Get the TLS Server Configuration Names from the Security.SSLConfigs table
GTLSSVRCNS(AconfigNames) Q $$GETTLSSERVERCNS^XUSUDO(.AconfigNames)
 ;
 ;
 ; Save the value of the global ^TMP("TLS",$J,"CONFIG","DEFAULT") in the 
 ; Kernel System Parameter "TLS CONFIGURATION" (FILE=8989.3, FIELD=667)
 ;   If there is no value in the global, store "UNKNOWN"
 ;
 ; D SAVETLSNAME^XUKSPTLSF()
 ;
SAVETLSNAME() ;
 NEW KSPFILE,KSPIEN,TLSFIELD,TLSNAME,RTNVAL
 NEW DIE,DA,DR,DIK
 I '$D(^TMP("TLS",$J,"CONFIG","DEFAULT")) D  G SVTLSNMDN
 . S RTNVAL="0^TMP(""TLS"",$J,""CONFIG"",""DEFAULT"") must be assigned the value you want saved"
 S KSPFILE=8989.3 ; File number of Kernel System Parameter file
 S KSPIEN=1  ; Only one record
 ; Set the Global root of the Kernel System Parameter file
 S KSPGLBROOT="^XTV("_KSPFILE_","
 ; Setup the DIE call
 S DIE=KSPGLBROOT    ; Global root of subfile
 S TLSFIELD=667
 S TLSNAME=$G(^TMP("TLS",$J,"CONFIG","DEFAULT"))
 S:$L(TLSNAME)=0 TLSNAME="UNKNOWN"
 S DA=KSPIEN
 S DR=""_TLSFIELD_"////"_TLSNAME
 D FMDIE
 S RTNVAL="1^Default TLS Config. saved."
SVTLSNMDN ;
 Q RTNVAL
 ;
 ;
 ; N TLSNA S TLSNA=""
 ; S QR=$$GTLSNAMES^XUKSPTLSF(.TLSNA)
 ;
GTLSNAMES(ATLSNAMESA) ;
 N RTNVAL,QR
 I '$D(ATLSNAMESA) D  G GTLSNMDN
 . S RTNVAL="0^Undefined TLS Names array parameter"
 S QR=$$GTLSSVRCNS(.ATLSNAMESA)
 I 'QR D  G GTLSNMDN
 . S RTNVAL="0^IRIS call to $$GETTLSSERVERCNS^XUSUDO() failed"
 M ^TMP("TLS",$J,"CONFIG","NAMES")=ATLSNAMESA
 S RTNVAL="1^GTLSNAMES"
GTLSNMDN ;
 Q RTNVAL
 ;
 ;
 ; Get the Form help message showing all TLS Configuration Names available
 ;
 ; N HMA S HMA=""
 ; W $$GTLSHM^XUKSPTLSF(.HMA)
 ;
GTLSHM(ATLSHMA) ;
 N RTNVAL
 S RTNVAL=1
 I '$D(ATLSHMA) D  G GTLSHMDN
 . S RTNVAL="0^Undefined TLS Help Message Parameter"
 S ATLSHMA(0)="Enter the number that corresponds to the TLS server configuration name:"
 N TLSNAMES,I
 S TLSNAMES(0)=0
 D GTLSNAMES(.TLSNAMES)
 I TLSNAMES(0)=0 D  G GTLSHMDN
 . S RTNVAL="0^There are no TLS Server Configurations available, see system administrator"
 . S ATLSHMA(0)=$P(RTNVAL,"^",2)
 F I=1:1:TLSNAMES(0)  D
 . S ATLSHMA(I)=""_I_". "_TLSNAMES(I)
GTLSHMDN ;
 Q RTNVAL
 ;
 ;
 ; Get TLS Configuration Name from global ^TMP("TLS",$J,"CONFIG","NAMES",AINDEX)
 ;   If there is no value in the global, return ""
 ;
 ; S INDEX=1 W $$GTLSG^XUKSPTLSF(INDEX)
 ;
GTLSG(AINDEX) ;
 N TLSNAME
 S TLSNAME=$G(^TMP("TLS",$J,"CONFIG","NAMES",AINDEX))
 Q TLSNAME
 ;
 ;
 ; Form post save routine
 ;
FRMPOSTS() ; FORM POST SAVE
 N RTNVAL S RTNVAL=0
 S RTNVAL="1^FORM POST SAVE Called"
 D SAVETLSNAME()
 K ^TMP("TLS",$J)
 Q RTNVAL
 ;
 ;
 ; Page Pre Action routine
 ;
PGPREA() ; PAGE PRE ACTION
 N RTNVAL,DTLSN
 K ^TMP("TLS",$J)
 S RTNVAL=$$GKSPTLSCN()
 Q RTNVAL
 ;
 ;
 ; TLS Name Pre routine
 ;
 ; N HLP S HLP=""
 ; S RTNVAL=$$TLSNPRE^XUKSPTLSF(.HLP)
 ;
TLSNPRE(ATLSNHMA) ;
 N RTNVAL
 S RTNVAL=$$GTLSHM(.ATLSNHMA)
 Q RTNVAL
 ;
 ; Field TLSN input transform.
 ; Transform the number entered by the Form user and passed as AINDEX to this function
 ; to the corresponding TLS Configuration Name saved in ^TMP("TLS",$J,"CONFIG","NAMES",AINDEX)
 ; Set the global ^TMP("TLS",$J,"CONFIG","DEFAULT") with the TLS Configuration Name
 ; found in ^TMP("TLS",$J,"CONFIG","NAMES",AINDEX).
 ;
 ; S INDEX=2 W $$TLSNX^XUKSPTLSF(INDEX)
 ;
TLSNX(AINDEX) ;
 N TLSNAME,INDEX,GTLSNAME,CNC
 S TLSNAME="0^UNKNOWN",CNC=0
 I $D(^TMP("TLS",$J,"CONFIG","NAMES",0)) S CNC=+(^TMP("TLS",$J,"CONFIG","NAMES",0))
 I CNC=1 S AINDEX=1
 S INDEX=+$G(AINDEX)
 I (INDEX'=AINDEX)!(INDEX<=0)!(INDEX>CNC) G TLSNXDN
 S GTLSNAME=$$GTLSG(INDEX)
 I $L(GTLSNAME)>2 D
 . S ^TMP("TLS",$J,"CONFIG","DEFAULT")=GTLSNAME
 . S TLSNAME="1^"_GTLSNAME
TLSNXDN ;
 Q TLSNAME
 ;
 ;
