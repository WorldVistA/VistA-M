DGRRPSKN ; ALB/SGG - rtnDGRR PatientServices Contact Information ;09/30/03  ; Compiled October 21, 2003 14:54:28
 ;;5.3;Registration;**557**;Aug 13, 1993
 ;
DOC ;<DataSet Name='NextOfKinAddress'
 ;
 ;
 ;=======================================================
 ; PRIMARY NEXT OF KIN
 ;.211      K-NAME OF PRIMARY NOK (FaX),         [.21;1]
 ;.212      K-RELATIONSHIP TO PATIENT (FX),      [.21;2]
 ;.213      K-STREET ADDRESS [LINE 1] (FX),      [.21;3]
 ;.214      K-STREET ADDRESS [LINE 2] (FX),      [.21;4]
 ;.215      K-STREET ADDRESS [LINE 3] (FX),      [.21;5]
 ;.216      K-CITY (FX),                         [.21;6]
 ;.217      K-STATE (P5'X),                      [.21;7]
 ;       .2207     K-ZIP+4 (FOX),        [.22;7]
 ;.218      K-ZIP CODE (FX),                     [.21;8]
 ;.219      K-PHONE NUMBER (FXa),                [.21;9]
 ;.21011    K-WORK PHONE NUMBER (F),             [.21;11]
 ;
 ;=======================================================
 ;SECONDARY NEXT OF KIN
 ;.2191     K2-NAME OF SECONDARY NOK (FX),       [.211;1]
 ;.2192     K2-RELATIONSHIP TO PATIENT (FX),     [.211;2]
 ;.2193     K2-STREET ADDRESS [LINE 1] (FX),     [.211;3]
 ;.2194     K2-STREET ADDRESS [LINE 2] (FX),     [.211;4]
 ;.2195     K2-STREET ADDRESS [LINE 3] (FX),     [.211;5]
 ;.2196     K2-CITY (FX),                        [.211;6]
 ;.2197     K2-STATE (P5'X),                     [.211;7]
 ;.2198     K2-ZIP CODE (FX),                    [.211;8]
 ;       .2203     K2-ZIP+4 (FOX),        [.22;3]
 ;.2199     K2-PHONE NUMBER (FX),                [.211;9]
 ;.211011   K2-WORK PHONE NUMBER (F),            [.211;11]
 ;
 ;=======================================================
 ; DESIGNEE
 ;.341      D-NAME OF DESIGNEE (FX),             [.34;1]
 ;.342      D-RELATIONSHIP TO PATIENT (FX),      [.34;2]
 ;.343      D-STREET ADDRESS [LINE 1] (FX),      [.34;3]
 ;.344      D-STREET ADDRESS [LINE 2] (FX),      [.34;4]
 ;.345      D-STREET ADDRESS [LINE 3] (FX),      [.34;5]
 ;.346      D-CITY (FX),                         [.34;6]
 ;.347      D-STATE (P5'X),                      [.34;7]
 ;.348      D-ZIP CODE (FX),                     [.34;8]
 ;       .2202     D-ZIP+4 (FOX),        [.22;2]
 ;.349      D-PHONE NUMBER (FX),                 [.34;9]
 ;.34011    D-WORK PHONE NUMBER (F),             [.34;11]
 ;
 ;=======================================================
 ; EMERGENCY CONTACT
 ;.331      E-NAME (FX),                         [.33;1]
 ;.332      E-RELATIONSHIP TO PATIENT (FX),      [.33;2]
 ;.333      E-STREET ADDRESS [LINE 1] (FX),      [.33;3]
 ;.334      E-STREET ADDRESS [LINE 2] (FX),      [.33;4]
 ;.335      E-STREET ADDRESS [LINE 3] (FX),      [.33;5]
 ;.336      E-CITY (FX),                         [.33;6]
 ;.337      E-STATE (P5'X),                      [.33;7]
 ;.338      E-ZIP CODE (FX),                     [.33;8]
 ;       .2201     E-ZIP+4 (FOX),        [.22;1]
 ;.339      E-PHONE NUMBER (FX),                 [.33;9]
 ;.33011    E-WORK PHONE NUMBER (F),             [.33;11]
 ;
 ;=======================================================
 ; SECONDARY EMERGENCY CONTACT
 ;.3311     E2-NAME OF SECONDARY CONTACT (FX),   [.331;1]
 ;.3312     E2-RELATIONSHIP TO PATIENT (FX),     [.331;2]
 ;.3313     E2-STREET ADDRESS [LINE 1] (FX),     [.331;3]
 ;.3314     E2-STREET ADDRESS [LINE 2] (FX),     [.331;4]
 ;.3315     E2-STREET ADDRESS [LINE 3] (FX),     [.331;5]
 ;.3316     E2-CITY (FX),                        [.331;6]
 ;.3317     E2-STATE (P5'X),                     [.331;7]
 ;.3318     E2-ZIP CODE (FX),                    [.331;8]
 ;       .2204     E2-ZIP+4 (FOX),        [.22;4]
 ;.3319     E2-PHONE NUMBER (FX),                [.331;9]
 ;.331011   E2-WORK PHONE NUMBER (F),            [.331;11]
 ;
 ;=======================================================
 ;
GETPSARY(PSARRAY) ;
 NEW CNT
 DO ADDRESS("NextOfKinAddress",$G(^DPT(PTID,.21)),7)
 DO ADDRESS("AltNextOfKinAddress",$G(^DPT(PTID,.211)),3)
 DO ADDRESS("DesigneeAddress",$G(^DPT(PTID,.34)),2)
 DO ADDRESS("EmergencyContactAddress",$G(^DPT(PTID,.33)),1)
 DO ADDRESS("AltEmergencyContactAddress",$G(^DPT(PTID,.331)),4)
 QUIT
 ;
ADDRESS(DATASET,ADGLOB,ZIP4) ;
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="<DataSet Name='"_DATASET_"'"
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^Street1^"_$P(ADGLOB,"^",3)
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^Street2^"_$P(ADGLOB,"^",4)
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^Street3^"_$P(ADGLOB,"^",5)
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^City^"_$P(ADGLOB,"^",6)
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^State^"_$$ADSTATE()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^Zip^"_$$ADZIP()
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^PhoneNumber^"_$P(ADGLOB,"^",9)
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^NameOfContact^"_$P(ADGLOB,"^",1)
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^RelationshipToPatient^"_$P(ADGLOB,"^",2)
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="^WorkPhoneNumber^"_$P(ADGLOB,"^",11)
 SET CNT=$G(CNT)+1,PSARRAY(CNT)="></DataSet>"_"^^^1"
 QUIT
 ;
ADSTATE() ;
 NEW DATA
 SET DATA=$P(ADGLOB,"^",7)
 IF DATA'="" SET DATA=$P($G(^DIC(5,DATA,0)),"^",2)
 QUIT DATA
 ;
 Q
ADZIP() ;
 NEW DATA
 SET DATA=$P(GLOB(.22),"^",ZIP4)
 IF DATA="" SET DATA=$P(ADGLOB,"^",8)
 QUIT DATA
 Q
