PXHFINQ ;SLC/PKR - Health Factor Inquire. ;01/11/2018
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 244
 ;
 ;==========================================
BHFINQ(IEN) ;Display an Health Factor inquiry, defaults to the Browswer.
 N BOP,DIR0,OUTPUT,TITLE,TYPE
 I '$D(^AUTTHF(IEN)) Q
 S TITLE="Health Factor Inquiry"
 D HFINQ(IEN,.OUTPUT)
 S BOP=$$BORP^PXRMUTIL("B")
 I BOP="" Q
 I BOP="B" D BROWSE^DDBR("OUTPUT","NR",TITLE)
 I BOP="P" D GPRINT^PXRMUTIL("OUTPUT")
 Q
 ;
 ;==========================================
HFINQ(IEN,OUTPUT) ;Health Factor inquiry, return the formatted text in OUTPUT.
 ;Use 80 column output.
 N CODE,CODELIST,CODESYS,IENSTR,IND,INDXDT,LEN,MAPDT
 N NL,NSP,RM,TEMP,TEXT,WPARRAY
 S RM=80
 S TEMP=^AUTTHF(IEN,0)
 S IENSTR="No. "_IEN
 S OUTPUT(1)=$$REPEAT^XLFSTR("-",RM)
 S TEXT=$P(TEMP,U,1)
 S NSP=RM-$L(TEXT)-1
 S OUTPUT(2)=TEXT_$$RJ^XLFSTR(IENSTR,NSP," ")
 S OUTPUT(3)=$$REPEAT^XLFSTR("-",RM)
 S OUTPUT(4)="Print Name: "_$$GET1^DIQ(9999999.64,IEN,200)
 S OUTPUT(5)="Class: "_$$GET1^DIQ(9999999.64,IEN,100)
 S OUTPUT(6)="Sponsor: "_$$GET1^DIQ(9999999.64,IEN,101)
 S OUTPUT(7)="Entry Type: "_$$GET1^DIQ(9999999.64,IEN,.1)
 S OUTPUT(8)="Category: "_$$GET1^DIQ(9999999.64,IEN,.03)
 S OUTPUT(9)="Display on Health Summary: "_$$GET1^DIQ(9999999.64,IEN,.08)
 S OUTPUT(10)="Inactive Flag: "_$$GET1^DIQ(9999999.64,IEN,.11)
 S OUTPUT(11)="Short Name: "_$$GET1^DIQ(9999999.64,IEN,.04)
 S TEXT="Lower Age: "_$$GET1^DIQ(9999999.64,IEN,.06)
 S TEXT=TEXT_"  Upper Age: "_$$GET1^DIQ(9999999.64,IEN,.07)
 S OUTPUT(12)=TEXT
 S OUTPUT(13)="Use Only With Sex: "_$$GET1^DIQ(9999999.64,IEN,.05)
 S OUTPUT(14)=""
 S OUTPUT(15)="Description:"
 S NL=15
 S TEMP=$$GET1^DIQ(9999999.64,IEN,201,"","WPARRAY")
 I TEMP="" S NL=NL+1,OUTPUT(NL)=""
 I TEMP="WPARRAY" D
 . S IND=0
 . F  S IND=$O(WPARRAY(IND)) Q:IND=""  S NL=NL+1,OUTPUT(NL)=WPARRAY(IND)
 . K WPARRAY
 ;
 ;Mapped Codes.
 S IND=0
 F  S IND=+$O(^AUTTHF(IEN,210,IND)) Q:IND=0  D
 . S TEMP=^AUTTHF(IEN,210,IND,0)
 . S CODESYS=$P(TEMP,U,1),CODE=$P(TEMP,U,2)
 . S MAPDT=$P(TEMP,U,3),INDXDT=$P(TEMP,U,4)
 . I CODE'="" S CODELIST(CODESYS,CODE)=MAPDT_U_INDXDT
 D MCDISP^PXMCODES(.CODELIST,.NL,.OUTPUT)
 ;
 ;
 ;Deleted code mappings.
 I $P($G(^AUTTHF(IEN,230,0)),U,4)>0 D
 . S NL=NL+1,OUTPUT(NL)=""
 . S NL=NL+1,OUTPUT(NL)=""
 . S NL=NL+1,OUTPUT(NL)="Deleted Code Mappings"
 . S IND=0
 . F  S IND=+$O(^AUTTHF(IEN,230,IND)) Q:IND=0  D
 .. S TEMP=^AUTTHF(IEN,230,IND,0)
 .. S NL=NL+1,OUTPUT(NL)=""
 .. S NL=NL+1,OUTPUT(NL)=" Coding System: "_$P(TEMP,U,1)_"  Code: "_$P(TEMP,U,2)
 .. S NL=NL+1,OUTPUT(NL)=" Date deleted: "_$$FMTE^XLFDT($P(TEMP,U,3),"5Z")
 .. S OUTPUT(NL)=OUTPUT(NL)_"  Deleted by: "_$$GET1^DIQ(200,$P(TEMP,U,4),.01)
 .. S NL=NL+1,OUTPUT(NL)=" Mapped Source Entry removal completion date: "_$$FMTE^XLFDT($P(TEMP,U,5),"5Z")
 . S NL=NL+1,OUTPUT(NL)=""
 ;
 S NL=NL+1,OUTPUT(NL)=""
 S NL=NL+1,OUTPUT(NL)="                             Value Range"
 S TEMP=$G(^AUTTHF(IEN,220))
 I TEMP="" S NL=NL+1,OUTPUT(NL)="Not defined"
 E  D
 . S NL=NL+1,OUTPUT(NL)=" Minimum Value                Maximum Value           UCUM Code"
 . S NL=NL+1,OUTPUT(NL)=$S($E(TEMP,1)="-":"",1:" ")_$P(TEMP,U,1)
 . S LEN=$L(OUTPUT(NL)),NSP=30-LEN
 . S OUTPUT(NL)=OUTPUT(NL)_$$REPEAT^XLFSTR(" ",NSP)_$P(TEMP,U,2)
 . N UCUMDATA,UCUMIEN
 . S UCUMIEN=+$P(TEMP,U,4)
 . I UCUMIEN>0 D
 ..;ICR #6225
 .. D UCUMDATA^LEXMUCUM(UCUMIEN,.UCUMDATA)
 .. S LEN=$L(OUTPUT(NL)),NSP=54-LEN
 .. S OUTPUT(NL)=OUTPUT(NL)_$$REPEAT^XLFSTR(" ",NSP)_UCUMDATA(UCUMIEN,"UCUM CODE")
 .. S NL=NL+1,OUTPUT(NL)=""
 .. S NL=NL+1,OUTPUT(NL)="UCUM Description: "_UCUMDATA(UCUMIEN,"DESCRIPTION")
 S NL=NL+1,OUTPUT(NL)=""
 Q
 ;
