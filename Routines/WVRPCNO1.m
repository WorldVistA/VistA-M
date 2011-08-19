WVRPCNO1 ;HIOFO/FT-WV PRINT LETTERS.  ;8/21/03  13:37
 ;;1.0;WOMEN'S HEALTH;**16**;Sep 30, 1998
 ;
 ; This routine uses the following IAs:
 ; #10063 - ^%ZTLOAD call          (supported)
 ; #10103 - ^XLFDT calls           (supported)
 ; #10104 - ^XLFSTR calls          (supported)
 ;
 ; The following entry point(s) are documented by IAs:
 ; LETTER  -  4103   (private)
 ;
DEVICE(WVDA,WVPRINTR) ; Queue to TaskMan to print letter
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 S ZTDESC="Print Women's Health letter"
 S ZTDTH=$$NOW^XLFDT()
 S ZTIO=WVPRINTR
 S ZTRTN="PRINT^WVRPCNO1"
 S ZTSAVE("WVDA")=""
 D ^%ZTLOAD
 Q
PRINT ; Print notification letter, update treatment needs & due dates
 ; required variable: wvda=ien in ^WV(790.4,
 I $D(ZTQUEUED) S ZTREQ="@"
 N BY,DIWF,WVDFN,WVKDT,WVPURP
 S IOP=ION
 S WVDFN=$P(^WV(790.4,WVDA,0),U)
 S WVPURP=$P(^WV(790.4,WVDA,0),U,4)
 S:'$D(WVKDT) WVKDT=$P(^WV(790.4,WVDA,0),U,11)
 ; if no purpose (deleted), kill "aprt" xref and quit.
 I 'WVPURP D  Q
 .D KILLXREF^WVLETPR(WVDA,WVKDT)
 S DIWF="^WV(790.404,WVPURP,1,"
 S DIWF(1)=790
 S BY="INTERNAL(#.01)="_WVDFN
 ; Compute future appointments
 D KAPPT^WVUTL9(WVDFN) ;kill off old computed appts.
 D GAPPT^WVUTL9(WVDFN) ;get future appts
 D SAPPT^WVUTL9(WVDFN) ;set appts in File 790
 D KILLUG^WVUTL9 ;kill off Utility global off future appts
 D KADD^WVUTL9(WVDFN) ;kill off old computed address
 D GADD^WVUTL9(WVDFN) ;get current complete address
 D SADD^WVUTL9(WVDFN) ;set complete address in File 790
 D KVAR^WVUTL9 ;clean-up VADPT variables used
 ; print the letter
 D EN2^DIWF
 ; don't stuff "date printed" if it already has a "date printed".
 I $P(^WV(790.4,WVDA,0),U,10)]"" D KILLXREF^WVLETPR(WVDA,WVKDT) Q
 ;
 ; next lines kill "aprt" xref and set "date printed"=today.
 ; ("aprt" xref indicate a notification is queued to be printed.)
 D KILLXREF^WVLETPR(WVDA,WVKDT)
 D DIE^WVFMAN(790.4,".1////"_DT,WVDA)
 Q
LETTER(RESULT,WVIEN) ; Returns the letter text for the purpose of
 ; notification
 ;  Input: RESULT - array name to return data in [required]
 ;          WVIEN - FILE 790.404 IEN [required]
 ;
 ; Output: RESULT(0)=First line of letter text   <OR>
 ;                   -1^error message
 ;         RESULT(n)= remaining lines of letter text
 I '$G(WVIEN) S RESULT(0)="-1^Purpose IEN not greater than 0" Q
 I '$D(^WV(790.404,WVIEN,0)) D  Q
 .S RESULT(0)="-1^No such purpose of notification"
 .Q
 I '$O(^WV(790.404,WVIEN,1,0)) D  Q
 .S RESULT(0)="-1^No letter defined for this purpose"
 .Q
 N WVCNT,WVLOOP
 S RESULT(0)="",(WVCNT,WVLOOP)=0
 F  S WVLOOP=$O(^WV(790.404,WVIEN,1,WVLOOP)) Q:'WVLOOP  D
 .S WVCNT=WVCNT+1
 .S RESULT(WVCNT)=$G(^WV(790.404,WVIEN,1,WVLOOP,0))
 .Q
 Q
 ;
GETDXIEN(WVX) ; Function returns FILE 790.31 IEN
 ;  Input:  WVX="A" for Abnormal
 ;              "N" for No Evidence of Malignancy
 ;              "U" for Unsatisfactory for Dx
 ; Output:  IEN of corresponding FILE 790.31 entry
 S WVX=$G(WVX,"")
 I WVX="" Q ""
 S WVX=$$UP^XLFSTR(WVX)
 I WVX="A" Q $O(^WV(790.31,"B","Abnormal",0))
 I WVX="N" Q $O(^WV(790.31,"B","No Evidence of Malignancy",0))
 I WVX="U" Q $O(^WV(790.31,"B","Unsatisfactory for Dx",0))
 Q ""
 ;
GETYPIEN(WVX) ; Function returns FILE 790.403 IEN
 ;  Input:  WVX="P" for CONTACT PHN
 ;          WVX="I" for CONVERSATION WITH PATIENT
 ;          WVX="L" for LETTER, FIRST
 ; Output: IEN of corresponding FILE 790.403 entry
 S WVX=$G(WVX,"")
 I WVX="" Q ""
 S WVX=$$UP^XLFSTR(WVX)
 I WVX="P" Q $O(^WV(790.403,"B","CONTACT PHN",0))
 I WVX="I" Q $O(^WV(790.403,"B","CONVERSATION WITH PATIENT",0))
 I WVX="L" Q $O(^WV(790.403,"B","LETTER, FIRST",0))
 Q ""
 ;
GETOIEN(WVX) ; Function returns FILE 790.405 IEN
 ;  Input: WVX = .01 value of FILE 790.405 entry (Outcome)
 ; Output: IEN of that entry
 S WVX=$G(WVX,"")
 I WVX="" Q ""
 Q $O(^WV(790.405,"B",WVX,0))
 ;
