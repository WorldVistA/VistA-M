EASEC100 ;ALB/BRM,LBD - Print 1010EC LTC Enrollment form ; 3/1/02 8:22am
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**5,7,16,40,45**;Mar 15, 2001
 ;
 ; This routine is called by EASEC10E to gather veteran data to be
 ; printed in the 1010EC (Long Term Care) form.
 ;
GETDATA(EASDFN,EAINFO) ;get veterans LTC data to be printed
 ;Input:
 ;   EASDFN - DFN for the Patient file (#2)
 ;Output:
 ;   ^TMP("1010EC",$J
 ;
 N EASROOT,DGINC,DGINR,DGREL,DGDEP
 S EASROOT="^TMP(""1010EC"",$J,"_EASDFN_","
 ; data for section 1
 D DATA1(EASDFN,.EAINFO,EASROOT)
 ; data for section 2
 D DATA2(EASDFN,EASROOT)
 ; data for section 3
 D DATA3(EASDFN,.EAINFO,EASROOT,.DGINC)
 ; data for section 4 and part of section 5
 D DATA4(EASDFN,EASROOT,.DGINC)
 ; data for section 5
 D DATA5(EASDFN,EASROOT,.DGINC)
 ; data for section 6
 D DATA6(EASDFN,EASROOT,.DGINC)
 ; data for section 8
 D DATA8(EASROOT,.EAINFO)
 Q
 ;
DATA1(EASDFN,EAINFO,EASROOT) ;data for section 1
 N EASINS,INSTMP,MDATA,EASROOT1,MPA,MPB,MPADT,MPBDT,MCN
 S EASROOT1=EASROOT_"1)"
 S @EASROOT1@(1)=$G(EAINFO("VET"))                     ;name
 S @EASROOT1@(2)=$G(EAINFO("SSN"))                      ;ssn
 S @EASROOT1@(3)=$$GET1^DIQ(2,EASDFN_",",".381","E")   ;medicaid
 ; **  determine medicare info
 S EASINS=0,(MPA,MPB)="NO",(MPADT,MPBDT,MCN)=""
 N EAX,INSUR
 I $$INSUR^IBBAPI(EASDFN,,"RA",.EAX,"*") ; Retrieve all active insurance
 I $D(EAX) D
 . M INSUR=EAX("IBBAPI","INSUR")
 . S EASINS=0
 . F  S EASINS=$O(INSUR(EASINS)) Q:'EASINS  D
 . . Q:$P(INSUR(EASINS,1),U,2)'["MEDICARE (WNR)"  ; Look for MEDICARE insurance 
 . . I $P(INSUR(EASINS,8),U,2)="PART A" S MPA="YES",MPADT=$$FMTE^XLFDT(INSUR(EASINS,10)),MCN=INSUR(EASINS,14) Q  ; If Policy Name is "PART A", set the Part A variables
 . . I $P(INSUR(EASINS,8),U,2)="PART B" S MPB="YES",MPBDT=$$FMTE^XLFDT(INSUR(EASINS,10)),MCN=INSUR(EASINS,14) Q  ; If Policy Name is "PART B", set the Part B variables
 S @EASROOT1@(4)=MPA      ;medicare part a
 S @EASROOT1@(5)=MPADT    ;medicare part a effective date
 S @EASROOT1@(6)=MPB      ;medicare part b
 S @EASROOT1@(7)=MPBDT    ;medicare part b effective date
 S @EASROOT1@(8)=MCN      ;medicare claim number
 Q
DATA2(EASDFN,EASROOT) ;data for section 2
 N EASI,EASINS,X,Z,EASROOT2,EASINS,CNT,NUM,EASIN1I,GRPIEN,INSUR,DGX
 S EASROOT2=EASROOT_"2)"
 S @EASROOT2@(1)=$$GET1^DIQ(2,EASDFN_",",".3192","E")  ;covered by ins
 ; Set up array by defining "null" palce holders
 F X=2:1:22 S @EASROOT2@(X)=""
 F I=3,10,17 F Z=.111:.001:.116 S @EASROOT2@(I,Z)=""
 ;
 S EASI=0,CNT=2
 I $$INSUR^IBBAPI(EASDFN,"","ARB",.DGX,"*") ; Call Insurance API for data
 M INSUR=DGX("IBBAPI","INSUR") ; Reformat insurance array into more friendly format
 F  S EASI=$O(INSUR(EASI)) Q:'EASI!(CNT>16)  D  ; Print out only first 3 entries found.
 . S @EASROOT2@(CNT+3)=$G(INSUR(EASI,13)) ; SUBSCRIBER NAME
 . S @EASROOT2@(CNT+4)=$P($G(INSUR(EASI,19)),U,2) ;relationship
 . S @EASROOT2@(CNT+5)=$G(INSUR(EASI,14)) ;policy # (SUBSCRIBER ID)
 . S @EASROOT2@(CNT+6)=$P($G(INSUR(EASI,8)),U,2) ; GROUP NAME
 .; Set Insurance Company Information
 . S @EASROOT2@(CNT)=$P($G(INSUR(EASI,1)),U,2) ; Insurance Co. Name
 . S @EASROOT2@(CNT+2)=$G(INSUR(EASI,6)) ; ins. phone
 . S @EASROOT2@((CNT+1),.111)=$G(INSUR(EASI,2)) ; INS. ADDRESS
 . S @EASROOT2@((CNT+1),.114)=$G(INSUR(EASI,3)) ; INS. CITY
 . S @EASROOT2@((CNT+1),.115)=$P($G(INSUR(EASI,4)),U,2) ; INS. STATE
 . S @EASROOT2@((CNT+1),.116)=$G(INSUR(EASI,5)) ; INS. ZIP
 .S CNT=CNT+7
 Q
INSDAT(EASINS,CNT) ;obtain insurance information from the insurance file (#36)
 Q:'EASINS
 N X,INSDAT,ERR
 D GETS^DIQ(36,EASINS_",",".01;.111:.116;.131","E","INSDAT","ERR")
 Q:$D(ERR)
 S @EASROOT2@(CNT)=$G(INSDAT(36,EASINS_",",.01,"E"))  ;insurance name
 F X=.111:.001:.116 S @EASROOT2@((CNT+1),X)=$G(INSDAT(36,EASINS_",",X,"E"))  ;insurance address
 S @EASROOT2@(CNT+2)=$G(INSDAT(36,EASINS_",",.131,"E"))  ;ins. phone
 Q
DATA3(EASDFN,EAINFO,EASROOT,DGINC) ;data for section 3
 N INFO13,DEP1,DEP,X,I,EASROOT3,SSN
 S EASROOT3=EASROOT_"3)"
 F X=0:1:11 S @EASROOT3@(X)=""
 D ALL^EASECU21(EASDFN,"SCV",EAINFO("MTDT"),"IPR",$G(EAINFO("DGMTIEN")))
 ;Marital Status added for LTC Phase IV (EAS*1*40)
 S @EASROOT3@(0)=$$GET1^DIQ(2,EASDFN,".05","E")
 S:$$GET1^DIQ(408.22,+$G(DGINR("V")),".17","I") @EASROOT3@(0)="LEGALLY SEPARATED"
 D:$D(DGREL("S"))
 .S INFO13=$G(^DGPR(408.13,+$P(DGREL("S"),"^",2),0))
 .S @EASROOT3@(1)=$P(INFO13,"^")  ;Spouse Name
 .S SSN=$P(INFO13,"^",9)          ;Spouse SSN
 .S @EASROOT3@(3)=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)
 .S:$G(DGINR("V")) @EASROOT3@(2)=$$GET1^DIQ(408.22,DGINR("V"),".16","E")                               ;Spouse Residing in the Community?
 Q:'$D(DGREL("C"))
 S DEP=""
 F  S DEP=$O(DGREL("C",DEP)) Q:'DEP!(DEP>2)  D
 .Q:'$D(^DGPR(408.13,+$P(DGREL("C",DEP),"^",2),0))
 .S INFO13=$G(^DGPR(408.13,+$P(DGREL("C",DEP),"^",2),0))
 .S DEP1=$S(DEP=1:4,DEP=2:8)
 .S @EASROOT3@(DEP1)=$P(INFO13,"^")                   ;Dependent Name
 .S @EASROOT3@(DEP1+1)=$$FMTE^XLFDT($P(INFO13,"^",3))  ;Dependent DOB
 .S SSN=$P(INFO13,"^",9)                               ;Dependent SSN
 .S @EASROOT3@(DEP1+2)=$E(SSN,1,3)_"-"_$E(SSN,4,5)_"-"_$E(SSN,6,9)
 .S:$G(DGINR("C",DEP)) @EASROOT3@(DEP1+3)=$$GET1^DIQ(408.22,DGINR("C",DEP),".16","E")                  ;Dependent Living in Community?
 Q
DATA4(EASDFN,EASROOT,DGINC) ;data for section 4 and the first part of 5
 N EASROOT4,EASROOT5,ASSETV,ASSETS,NUM,X,ASSETRT,IENS,I
 S EASROOT4=EASROOT_"4)"
 S EASROOT5=EASROOT_"5)"
 ;Add subscripts to array to store assets for spouse (needed for new
 ;10-10EC form).  LTC Phase IV (EAS*1*40)
 F I=1:.5:4.5 S @EASROOT4@(I)=""
 F I=1:.5:5.5 S @EASROOT5@(I)=""
 F X="V","S" Q:'$D(DGINC(X))  D
 .D GETS^DIQ(408.21,+DGINC(X),"2.01;2.02;2.06:2.09","I","ASSET"_X)
 .S NUM=$S(X="V":1,1:1.5)
 .S IENS=+DGINC(X)_","
 .S ASSETRT="ASSET"_X_"(408.21,"_""""_IENS_""""_","
 .;Fixed Assets
 .S @EASROOT4@(NUM)=+$G(@(ASSETRT_"2.06,""I"")")) ;Residence
 .S @EASROOT4@(NUM+1)=+$G(@(ASSETRT_"2.07,""I"")")) ;Land/Farm
 .S @EASROOT4@(NUM+2)=+$G(@(ASSETRT_"2.08,""I"")")) ;Vehicles
 .;Liquid Assets
 .S @EASROOT5@(NUM)=+$G(@(ASSETRT_"2.01,""I"")")) ;Cash
 .S @EASROOT5@(NUM+1)=+$G(@(ASSETRT_"2.02,""I"")")) ;Stocks
 .S @EASROOT5@(NUM+2)=+$G(@(ASSETRT_"2.09,""I"")")) ;Other
 .;Subtotals
 .F I=NUM:1:(NUM+2) S @EASROOT4@(NUM+3)=@EASROOT4@(NUM+3)+@EASROOT4@(I),@EASROOT5@(NUM+3)=@EASROOT5@(NUM+3)+@EASROOT5@(I) ;Sub-totals
 S @EASROOT5@(5)=@EASROOT4@(4)+@EASROOT5@(4)  ;Total Assets Vet
 S @EASROOT5@(5.5)=@EASROOT4@(4.5)+@EASROOT5@(4.5)  ;Total Assets Spouse
 Q
DATA5(EASDFN,EASROOT,DGINC) ;data for section 5 (the rest of it)
 N EASROOT5,ASSETV,ASSETS,NUM,X,ASSETRT,IENS,I
 S EASROOT5=EASROOT_"5)"
 F I=6:1:35 S @EASROOT5@(I)=""
 F X="V","S" Q:'$D(DGINC(X))  D  ;
 .D GETS^DIQ(408.21,+DGINC(X),".06:.2","I","ASSET"_X)
 .S NUM=$S(X="V":6,X="S":7)
 .S IENS=+DGINC(X)_","
 .S ASSETRT="ASSET"_X_"(408.21,"_""""_IENS_""""_","
 .S @EASROOT5@(NUM)=+$G(@(ASSETRT_".14,""I"")"))    ;Gross Income
 .S @EASROOT5@(NUM+2)=+$G(@(ASSETRT_".08,""I"")"))  ;Soc. Security
 .S @EASROOT5@(NUM+4)=+$G(@(ASSETRT_".15,""I"")"))  ;Interest/Div
 .S @EASROOT5@(NUM+6)=+$G(@(ASSETRT_".06,""I"")"))  ;Retire/Pension
 .S @EASROOT5@(NUM+8)=+$G(@(ASSETRT_".09,""I"")"))  ;Civil Service
 .S @EASROOT5@(NUM+10)=+$G(@(ASSETRT_".1,""I"")"))  ;US Railroad
 .S @EASROOT5@(NUM+12)=+$G(@(ASSETRT_".07,""I"")"))  ;VA Pension
 .S @EASROOT5@(NUM+14)=+$G(@(ASSETRT_".19,""I"")"))  ;Spouse Disab
 .S @EASROOT5@(NUM+16)=+$G(@(ASSETRT_".12,""I"")"))  ;Unemployment
 .S @EASROOT5@(NUM+18)=+$G(@(ASSETRT_".16,""I"")"))  ;Workers Comp,etc
 .S @EASROOT5@(NUM+20)=+$G(@(ASSETRT_".11,""I"")"))  ;Military Retire
 .S @EASROOT5@(NUM+22)=+$G(@(ASSETRT_".13,""I"")"))  ;Other Retire
 .S @EASROOT5@(NUM+24)=+$G(@(ASSETRT_".2,""I"")"))  ;Court Mandated
 .S @EASROOT5@(NUM+26)=+$G(@(ASSETRT_".17,""I"")"))  ;Other Income
 .F I=NUM:2:NUM+26 S @EASROOT5@(NUM+28)=@EASROOT5@(NUM+28)+@EASROOT5@(I)  ;Total Income
 Q
DATA6(EASDFN,EASROOT,DGINC) ;
 N IENS,EXPRT,EASROOT6,EXPENSE
 S EASROOT6=EASROOT_"6)"
 F I=1:1:11 S @EASROOT6@(I)=""
 Q:'$G(DGINC("V"))
 D GETS^DIQ(408.21,+DGINC("V"),"1.01:1.1","I","EXPENSE")
 S IENS=+DGINC("V")_","
 S EXPRT="EXPENSE(408.21,"_""""_IENS_""""_","
 S @EASROOT6@(1)=+$G(@(EXPRT_"1.03,""I"")"))  ;Education
 S @EASROOT6@(2)=+$G(@(EXPRT_"1.02,""I"")"))  ;Funeral and Burial
 S @EASROOT6@(3)=+$G(@(EXPRT_"1.04,""I"")"))  ;Rent/Mortgage
 S @EASROOT6@(4)=+$G(@(EXPRT_"1.05,""I"")"))  ;Utilities
 S @EASROOT6@(5)=+$G(@(EXPRT_"1.06,""I"")"))  ;Car Payment
 S @EASROOT6@(6)=+$G(@(EXPRT_"1.07,""I"")"))  ;Food
 S @EASROOT6@(7)=+$G(@(EXPRT_"1.01,""I"")"))  ;Medical Expenses
 S @EASROOT6@(8)=+$G(@(EXPRT_"1.08,""I"")"))  ;Court-Ordered Payments
 S @EASROOT6@(9)=+$G(@(EXPRT_"1.09,""I"")"))  ;Insurance
 S @EASROOT6@(10)=+$G(@(EXPRT_"1.1,""I"")"))  ;Taxes (Income, etc)
 F I=1:1:10 S @EASROOT6@(11)=@EASROOT6@(11)+@EASROOT6@(I)  ;Total Expenses
 Q
DATA8(EASROOT,EAINFO) ;get the word processing field for section 8
 N LINE,X,EASROOT8,IENS,WP
 S EASROOT8=EASROOT_"8)",LINE=0
 Q:'EAINFO("DGMTIEN")
 S IENS=EAINFO("DGMTIEN")_","
 S X=$$GET1^DIQ(408.31,IENS,50,"","WP")
 F  S LINE=$O(WP(LINE)) Q:'LINE  S @EASROOT8@(LINE)=$G(WP(LINE))
 Q
