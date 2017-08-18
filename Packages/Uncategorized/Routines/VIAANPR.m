VIAANPR ;ALB/WW - New Person / Employee RPCs for RTLS ;4/20/16 10:09 pm
 ;;1.0;RTLS;**4**;April 22, 2013;Build 21
 ;;
 ;; RTLS New Person / Employee RPC calls
 Q
 ;
 ; Reference to ^VA(200 supported by IA #10060
 ;
 ;----------------------------------------------------------------------------
RTLSNP(RETSTA,REQDATA,DATAID) ; Retrieve Employee Information.
 ;
 ; This RPC allows retrieval of the following fields from 
 ; the New Person File (#200):
 ;   IEN
 ;   NAME ( #.01)
 ;   DIVISION (#16)
 ;   SEX (#4)
 ;   DOB (#5)
 ;   TITLE (#8)
 ;   SERVICE/SECTION (#29)
 ;
 ; Input:
 ;   RETSTA - name of the return array
 ;   REQDATA - identifies the type of data that is being requested:
 ;     "IEN" defines DATAID as a Social Security Number
 ;     "NAME" defines DATAID as a Name/Partial Name
 ;   DATAID - identifies which data is to be returned for REQDATA:
 ;     IEN if REQDATA="IEN"
 ;     NAME/PARTIAL NAME if REQDATA="NAME"
 ; Output:
 ;   Global ^TMP("VIAA"_REQDATA,$J,n)
 ;     Contains data elements when REQDATA and DATAID are passed in as
 ;     input parameters and are defined as follows:
 ;       "IEN^FIRSTNAME^LASTNAME^MIDDLENAME^DIVISION^SEX^DOB^TITLE...
 ;       ...^SERVICE/SECTION^NETWORK USERNAME"
 ;     or an error condition:
 ;       "-###^" concatenated with reason for failure is returned,
 ;     where '###' is a 3-digit code
 ;
 N TMP,TVIAA,VIAA,VIAACNT,VIAAIEN,VIAAOUT
 ;
 S VIAA="VIAA"_REQDATA
 ;
 K ^TMP(VIAA,$J)
 ;
 I $G(REQDATA)="" S ^TMP(VIAA,$J,0)="-400^REQDATA must be the keyword 'IEN' or 'NAME'" D OUTPUT Q
 ;
 I $G(DATAID)="" D  Q 
 .I $G(REQDATA)="NAME" S ^TMP(VIAA,$J,0)="-400^Name cannot be null" D OUTPUT
 .I $G(REQDATA)="IEN" S ^TMP(VIAA,$J,0)="-400^IEN cannot be null" D OUTPUT
 I "^IEN^NAME^"'[(U_REQDATA_U) D  Q
 .S ^TMP(VIAA,$J,0)="-400^REQDATA must be the keyword 'IEN' or 'NAME'"
 .D OUTPUT
 ;
 I REQDATA="IEN" D  Q
 .I '$D(^VA(200,DATAID)) D  D OUTPUT Q
 ..S ^TMP(VIAA,$J,0)="-400^("_DATAID_") not a recognized IEN"
 .S VIAAIEN=DATAID
 .D BUILD(0),OUTPUT
 ;
 ;I DATAID="*" D  D OUTPUT Q
 ;.S TMP="",VIAACNT=-1
 ;.F  S TMP=$O(^VA(200,"B",TMP)) Q:TMP=""  D
 ;..S VIAAIEN=$O(^VA(200,"B",TMP,""))
 ;..I VIAAIEN]"" S VIAACNT=VIAACNT+1 D BUILD(VIAACNT)
 ;
 I $E(DATAID,1)="'" S DATAID=$E(DATAID,2,$L(DATAID))
 I $E(DATAID,$L(DATAID))="'" S DATAID=$E(DATAID,1,($L(DATAID)-1))
 ;
 D FIND^DIC(200,,,"B",DATAID,,,,,"VIAAOUT")
 ;
 I '$D(VIAAOUT("DILIST",2)) D  Q
 .S ^TMP(VIAA,$J,0)="-404^no name match found for ("_DATAID_")"
 .D OUTPUT
 ;
 S TVIAA="" F VIAACNT=0:1 S TVIAA=$O(VIAAOUT("DILIST",2,TVIAA)) Q:TVIAA=""  D
 .S VIAAIEN=VIAAOUT("DILIST",2,TVIAA)
 .D BUILD(VIAACNT)
 ;
 D OUTPUT
 ;
 Q
 ;----------------------------------------------------------------------------
BUILD(VIAACNT) ; Build the ^TMP output entries.
 ;
 N TMP,VIAADIV,VIAADOB,VIAANAME,VIAATMP
 ;
 S (VIAATMP,VIAADIV)=""
 I $P($G(^VA(200,VIAAIEN,2,0)),U,3)'="" D
 .F  S VIAATMP=$O(^VA(200,VIAAIEN,2,"B",VIAATMP)) Q:VIAATMP=""  D
 ..S VIAADIV=$$GET1^DIQ(200.02,VIAATMP_","_VIAAIEN_",",.01,"I")
 ;
 S VIAADOB=$$GET1^DIQ(200,VIAAIEN_",","DOB")
 I VIAADOB]"" D
 .D DT^DILF("TS",VIAADOB,.VIAADOB)
 .I VIAADOB]"" D
 ..S VIAADOB=$E(VIAADOB,4,5)_"/"_$E(VIAADOB,6,7)_"/"_$E((1700+$E(VIAADOB,1,3)),1,4)
 ;
 S TMP=$$GET1^DIQ(200,VIAAIEN_",","NAME")
 S VIAANAME=$P(TMP,",")_U_$P($P(TMP,",",2)," ")_U_$P($P(TMP,",",2)," ",2,3)
 ;
 S VIAATMP=VIAAIEN_U_VIAANAME
 S VIAATMP=VIAATMP_U_$S(VIAADIV]"":VIAADIV,1:$$STA^XUAF4($$KSP^XUPARAM("INST")))
 S VIAATMP=VIAATMP_U_$$GET1^DIQ(200,VIAAIEN_",","SEX","I")
 S VIAATMP=VIAATMP_U_VIAADOB
 S VIAATMP=VIAATMP_U_$$GET1^DIQ(200,VIAAIEN_",","TITLE")
 S VIAATMP=VIAATMP_U_$$GET1^DIQ(200,VIAAIEN_",","SERVICE/SECTION")
 S VIAATMP=VIAATMP_U_$$GET1^DIQ(200,VIAAIEN_",","NETWORK USERNAME")
 S ^TMP(VIAA,$J,VIAACNT)=VIAATMP
 ;
 Q
 ;----------------------------------------------------------------------------
OUTPUT ; Move the ^TMP data to the output array RETSTA
 ;
 M RETSTA=^TMP(VIAA,$J)
 ;
 Q
