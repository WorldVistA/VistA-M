MCARAPI ; HOIFO/NCA - Electrocardiogram Data Extraction ;7/3/96  09:13
 ;;2.3;Medicine;**34**;09/13/1996
 ; Reference IA #3780
 ;           IA #10154 Access 2nd piece of ^DD(filenumber,fieldnumber,0)
GET(RESULTS,MCARDFN,MCSDT,MCEDT,MCFLDS) ; Returns list of data from Electrocardiogram File #691.5
 ; Input: RESULTS - the global array in which  (Required)
 ;                  to return results.
 ;        MCARDFN - the patient DFN.           (Required)
 ;        MCSDT - the start date of the date   (Required)
 ;                range to return the data in.
 ;                This must be in FM internal
 ;                format.
 ;        MCEDT - the end date of the date     (Required)
 ;                range to return the data in.
 ;                This must be in FM internal
 ;                format.
 ;        MCFLDS - a list of fields from file #691.5 to  (Required)
 ;                 be returned in RESULTS.  MCFLDS should
 ;                 contain a list of fields delimited by ";"
 ;                 example: MCFLDS=".01;11;20..."
 ;
 ; Output: RESULTS  (Passed by Reference)
 ;         Global array return in the following FM DIQ call format:
 ;         example:
 ;          ^TMP("MCDATA",$J,file #,record ien_",",field #,"E")=Data
 ;          ^TMP("MCDATA",$J,subfile #,entry #_","_record ien,
 ;                field of the multiple,"E")=data
 ;     
 ;         Only the Electrocardiogram records in the following
 ;         statuses will be returned in the list:
 ;  
 ;         RELEASED ON-LINE VERIFIED
 ;         RELEASED OFF-LINE VERIFIED
 ;         RELEASED NOT VERIFIED
 ;         RELEASED ON-LINE VERIFIED OF SUPERSEDED
 ;         RELEASED OFF-LINE VERIFIED OF SUPERSEDED
 ;
 ;         RESULTS(0) will equal one of the following, if the call
 ;         failed:
 ;             -1^No Patient DFN.
 ;             -1^No Start Date Range.
 ;             -1^No End Date Range.
 ;             -1^Start Date greater than End Date.
 ;             -1^No fields defined.
 ;             -1^Global TMP array only.
 ;         If no return array defined,^TMP("MCAPI",$J,0) equals
 ;             -1^No return array global.
 ;
 ;         If no data, RESULTS(0) equals
 ;             -1^No data for patient.
 ;
 N MCCODE,MCDR,MCK,MCLP,MCN,MCNOD,MCSUBF,MCX,MCY
 K ^TMP("MCAPI",$J)
 I '$D(RESULTS) S ^TMP("MCAPI",$J,0)="-1^No return array global." Q
 I $G(RESULTS)'["^TMP" S ^TMP("MCAPI",$J,0)="-1^Global TMP array only." Q
 I '+$G(MCARDFN) S @RESULTS@(0)="-1^No Patient DFN." Q
 I '$G(MCSDT) S @RESULTS@(0)="-1^No Start Date Range." Q
 I '$G(MCEDT) S @RESULTS@(0)="-1^No End Date Range." Q
 I MCSDT>MCEDT S @RESULTS@(0)="-1^Start Date greater than End Date." Q
 I $G(MCFLDS)="" S @RESULTS@(0)="-1^No fields defined." Q
 S (MCDR,MCX,MCY)="",MCEDT=MCEDT\1+.3
 S MCN=$L(MCFLDS,";")
 F MCK=1:1:MCN S MCY=+$P(MCFLDS,";",MCK) I MCY D
 .Q:'$$VFIELD^DILFD(691.5,MCY)
 .S MCNOD=$P($G(^DD(691.5,+MCY,0)),"^",2),MCSUBF=0
 .I +MCNOD[691.5&($E(MCNOD,$L(MCNOD)-1,$L(MCNOD))="PA") S MCSUBF=1
 .S MCDR=MCDR_$S(MCDR="":"",1:";")_MCY_$S(MCSUBF:"*",1:"")
 .Q
 S MCLP=0 F  S MCLP=$O(^MCAR(691.5,"C",MCARDFN,MCLP)) Q:MCLP<1  D
 .S MCX=$G(^MCAR(691.5,MCLP,0)) Q:MCX=""
 .Q:$P(MCX,"^")<MCSDT!($P(MCX,"^")>MCEDT)
 .S MCCODE=$P($G(^MCAR(691.5,MCLP,"ES")),"^",7)
 .S:MCCODE="" MCCODE="RNV"
 .I MCCODE="S"!(MCCODE["D") Q
 .D GETS^DIQ(691.5,MCLP_",",MCDR,"E",$NA(@RESULTS))
 .Q
 I '$D(@(RESULTS)) S @RESULTS@(0)="-1^No data for patient."
 Q
