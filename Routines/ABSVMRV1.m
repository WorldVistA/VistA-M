ABSVMRV1 ;OAKLANDFO/DPC-VSS MIGRATION;7/23/2002
 ;;4.0;VOLUNTARY TIMEKEEPING;*31*;Jul 1994
 ;
 ;Reference file validation
ORGVAL(FLAG,VALRES) ;
 N ORGIEN,ORG0,ORGIDEN
 N CODE
 K ^TMP("ABSVM",$J,"ORGCODES")
 S VALRES("ERRCNT")=0
 S VALRES("DA")=$$CRERRLOG^ABSVMUT1("G",$G(FLAG))
 I VALRES("DA")=0 W !,"There was an error creating VALIDATION RESULTS entry for Organizations." Q
 S ORGIEN=899
 F  S ORGIEN=$O(^ABS(503334,ORGIEN)) Q:ORGIEN=""  D
 . N ERRS
 . S ERRS=0
 . S ORG0=$G(^ABS(503334,ORGIEN,0))
 . S ORGIDEN="Volunteer Organizations Codes record #"_ORGIEN
 . I ORG0="" D ADDERR^ABSVMVV1(ORGIDEN_" does not exist.",.ERRS) Q
 . ;CODE
 . D
 . . S CODE=$P(ORG0,U)
 . . I CODE="" D ADDERR^ABSVMVV1(ORGIDEN_" is missing a Code.",.ERRS) Q
 . . I CODE'?3N D ADDERR^ABSVMVV1(ORGIDEN_" has an incorrect Code.",.ERRS) Q
 . . I $D(^TMP("ABSVM",$J,"ORGCODES",CODE)) D ADDERR^ABSVMVV1(ORGIDEN_" has a duplicate Code of "_CODE_" with record #"_$G(^TMP("ABSVM",$J,"ORGOCDES",CODE))_".",.ERRS) Q
 . . S ^TMP("ABSVM",$J,"ORGCODES",CODE)=ORGIEN ;array of local org codes.
 . . S OCDS(ORGIEN)="" ;array of acceptable Org Code entries.
 . ;ORG NAME
 . I $P(ORG0,U,2)="" D ADDERR^ABSVMVV1(ORGIDEN_" is missing an organization name.",.ERRS)
 . I $L($P(ORG0,U,2))>35 D ADDERR^ABSVMVV1(ORGIDEN_" has an Organization Name that is longer than 35 characters.",.ERRS)
 . ;ABBREV.
 . I $L($P(ORG0,U,3))>6!($L($P(ORG0,U,4))>6) D ADDERR^ABSVMVV1(ORGIDEN_" has an Abbreviation longer than 6 characters.",.ERRS)
 . ;INACTIVE
 . I ",0,1,,"'[(","_$P(ORG0,U,5)_",") D ADDERR^ABSVMVV1(ORGIDEN_" has an invalid Inactive Code.",.ERRS)
 . I ERRS>0 D RECERR^ABSVMUT1(.VALRES,.ERRS) Q
 . S OCDS(ORGIEN)="" ;Array of good org IENS for validating hours.
 . I $G(FLAG)["S" S ^XTMP("ABSVMORG","IEN",ORGIEN)=""
 . Q
 D ERRCNT^ABSVMUT1(.VALRES)
 K ^TMP("ABSVM",$J,"ORGCODE")
 Q
 ;
SRVVAL(FLAG,VALRES) ;
 N SRVIEN,SRV0,SRVIDEN
 N CODE,SRVNAME
 K ^TMP("ABSVM",$J,"SRVCODES")
 S VALRES("ERRCNT")=0
 S VALRES("DA")=$$CRERRLOG^ABSVMUT1("S",$G(FLAG))
 I VALRES("DA")=0 W !,"There was an error creating VALIDATION RESULTS entry for Services." Q
 S SRVIEN=0
 F  S SRVIEN=$O(^ABS(503332,SRVIEN)) Q:SRVIEN=""  D
 . N ERRS,LOWCODE
 . S ERRS=0
 . S SRV0=$G(^ABS(503332,SRVIEN,0))
 . S SRVIDEN="Voluntary Service Assignment Codes record #"_SRVIEN
 . I SRV0="" D ADDERR^ABSVMVV1(SRVIDEN_" does not exist.",.ERRS) Q
 . ;CODE
 . D  Q:LOWCODE
 . . S LOWCODE=0
 . . S CODE=$P(SRV0,U)
 . . I CODE="" D ADDERR^ABSVMVV1(SRVIDEN_" is missing a Code.",.ERRS) Q
 . . I CODE'?3N.1A D ADDERR^ABSVMVV1(SRVIDEN_" has an incorrect Code.",.ERRS) Q
 . . I CODE<800 S LOWCODE=1 Q
 . . I $D(^TMP("ABSVM",$J,"SRVCODES",CODE)) D ADDERR^ABSVMVV1(SRVIDEN_" has a duplicate Code of "_CODE_" with record #"_^TMP("ABSVM",$J,"SRVCODES",CODE)_".",.ERRS) Q
 . . S ^TMP("ABSVM",$J,"SRVCODES",CODE)=SRVIEN ;Array of local service codes.
 . . S SCDS(SRVIEN)="" ;Array of usable service code IENs
 . ;SERVICE NAME
 . S SRVNAME=$P(SRV0,U,2)
 . I SRVNAME="" D ADDERR^ABSVMVV1(SRVIDEN_" is missing service name.",.ERRS)
 . I $L($P(SRVNAME,"-"))>35 D ADDERR^ABSVMVV1(SRVIDEN_" has Service Name that is longer than 35 characters.",.ERRS)
 . I $L($P(SRVNAME,"-",2))>30 D ADDERR^ABSVMVV1(SRVIDEN_" has a Service Subdivision longer than 30 characters.",.ERRS)
 . ;ABBREV.
 . I $L($P(SRV0,U,3))>7 D ADDERR^ABSVMVV1(SRVIDEN_" has an Abbreviation longer than 6 characters.",.ERRS)
 . I ERRS>0 D RECERR^ABSVMUT1(.VALRES,.ERRS) Q
 . S SCDS(SRVIEN)="" ;Array of good service IENS used in hours' validation.
 . I $G(FLAG)="S" S ^XTMP("ABSVMSERV","IEN",SRVIEN)=""
 . Q
 D ERRCNT^ABSVMUT1(.VALRES)
 K ^TMP("ABSVM",$J,"SRVCODE")
 Q
