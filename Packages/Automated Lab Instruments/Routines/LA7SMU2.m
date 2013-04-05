LA7SMU2 ;DALOI/JMC - Shipping Manifest Utility (Cont'd) ;11/17/11  08:50
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**46,64,74**;Sep 27, 1994;Build 229
 ;
 Q
 ;
 ; ZEXCEPT is used to identify variables which are external to a specific TAG
 ;         used in conjunction with Eclipse M-editor.
 ;
DTTO(LA7SCFG,LA7VNLT,LA7HLSC,LA7HLPRI,LA7HLCSC) ; Determine test to order
 ; Call with LA7SCFG = ien of Shipping Configuration file #62.9
 ;           LA7VNLT = NLT code or non-VA test code (pass by reference)
 ;           LA7HLSC = Specimen Code (pass by reference)
 ;          LA7HLPRI = HL7 Priority Code
 ;          LA7HLCSC = Collection sample (pass by reference)
 ;
 ; Returns      LA7X = 0^0^0^0^^^ (if unsuccessful)
 ;                     LABORATORY TEST (ien file #60)^TOPOGRAPHY (ien file #61)^COLLECTION SAMPLE (ien file #62)^URGENCY (ien file #62.05)^NLT TEST CODE^NLT TEST NAME
 ;
 N I,J,K,L,LA760,LA7X,X,Y,Z
 ;
 ; Make sure variables initialized.
 S LA7X="0^0^0^0^^^"
 I LA7VNLT="" Q LA7X
 S LA7SCFG=+$G(LA7SCFG)
 I LA7HLPRI="" S LA7HLPRI="R"
 ;
 ; If coding systems not defined then assume HL7 Table 0070 and VA NLT file
 F I=1,4 D
 . I $G(LA7HLSC(I))'="",$G(LA7HLSC(I+2))="" S LA7HLSC(I+2)="HL70070"
 . I $G(LA7VNLT(I))'="" D
 . . I $G(LA7VNLT(I+2))="" S LA7VNLT(I+2)="L"
 . . I $G(LA7VNLT(I+2))="L",$P(^LAHM(62.9,LA7SCFG,0),"^",15)=0 S LA7VNLT(I+2)="99VA64"
 . I $G(LA7HLCSC(I))'="",$G(LA7HLCSC(I+2))="" S LA7HLCSC(I+2)="L"
 ;
 ; Build index of tests if not previously done for this session.
 I '$D(^TMP("LA7TC",$J,LA7SCFG)) D BINDX^LA7SMU2A
 ;
 ; Lookup test/specimen/priority/collection sample mapping
 F I=1,4 D  Q:LA7X
 . I $G(LA7VNLT(I))="" Q
 . F J=1,4 D  Q:LA7X
 . . I $G(LA7HLSC(J))="" Q
 . . F K=1,4 D  Q:LA7X
 . . . F L=LA7HLPRI,0 D  Q:LA7X
 . . . . I $G(LA7HLCSC(K))="" Q
 . . . . S X=$G(^TMP("LA7TC",$J,LA7SCFG,LA7VNLT(I+2),LA7VNLT(I),LA7HLSC(J+2),LA7HLSC(J),L,LA7HLCSC(K+2),LA7HLCSC(K)))
 . . . . I X S LA7X=X
 . . . I LA7X Q
 . . . S X=$G(^TMP("LA7TC",$J,LA7SCFG,LA7VNLT(I+2),LA7VNLT(I),LA7HLSC(J+2),LA7HLSC(J),LA7HLPRI))
 . . . I X S LA7X=X
 . . I LA7X Q
 . . S X=$G(^TMP("LA7TC",$J,LA7SCFG,LA7VNLT(I+2),LA7VNLT(I),LA7HLSC(J+2),LA7HLSC(J)))
 . . I X S LA7X=X
 . I LA7X Q
 . F K=1,4 D  Q:LA7X
 . . F L=LA7HLPRI,0 D  Q:LA7X
 . . . I $G(LA7HLCSC(K))="" Q
 . . . S X=$G(^TMP("LA7TC",$J,LA7SCFG,LA7VNLT(I+2),LA7VNLT(I),0,0,L,LA7HLCSC(K+2),LA7HLCSC(K)))
 . . . I X,$P(^LAB(60,$P(X,"^"),0),"^",4)="MI" S LA7X=X Q
 . . . S X=$G(^TMP("LA7TC",$J,LA7SCFG,LA7VNLT(I+2),LA7VNLT(I),"HL70070","XXX",L,LA7HLCSC(K+2),LA7HLCSC(K)))
 . . . I X,"SPCYEM"[$P(^LAB(60,$P(X,"^"),0),"^",4) S LA7X=X
 . I LA7X Q
 . S X=$G(^TMP("LA7TC",$J,LA7SCFG,LA7VNLT(I+2),LA7VNLT(I),0,0,0,0,0))
 . I X S LA7X=X
 ;
 ; If SCT specimen from message does not match SCT assigned to specimen from above
 ;  then use SCT specimen from message to insure correct specimen on order.
 I $P(LA7X,"^"),$P(LA7X,"^",2) D
 . F J=1,4 I $G(LA7HLSC(J+2))="SCT" D  Q
 . . I LA7HLSC(J)=$P($G(^LAB(61,$P(LA7X,"^",2),"SCT")),"^") Q
 . . S X=$O(^LAB(61,"F",LA7HLSC(J),""))
 . . I X<1 S X=+$$FINDSCT(61,LA7HLSC(J),LA7HLSC(J+1))
 . . I X>0 S $P(LA7X,"^",2)=X
 ;
 ; If SCT collection sample from message does not match SCT assigned to collection sample from above
 ;  then use SCT collection sample from message to insure correct collection sample on order.
 I $P(LA7X,"^"),$P(LA7X,"^",3) D
 . F J=1,4 I $G(LA7HLCSC(J+2))="SCT" D  Q
 . . I LA7HLCSC(J)=$P($G(^LAB(62,$P(LA7X,"^",3),"SCT")),"^") Q
 . . S X=$O(^LAB(62,"F",LA7HLCSC(J),""))
 . . I X<1 S X=+$$FINDSCT(62,LA7HLCSC(J),LA7HLCSC(J+1))
 . . I X>0 S $P(LA7X,"^",3)=X
 ;
 ; For MI, SP, CY and EM find first specimen when collection sample is not mapped to a specific topography.
 ; For SP, CY and EM if no specimen then find first specimen mapped to HL7 0070 "XXX".
 I $P(LA7X,"^"),'$P(LA7X,"^",2),$P(^LAB(60,$P(LA7X,"^"),0),"^",4)?1(1"MI",1"SP",1"CY",1"EM") D
 . S X=""
 . F J=1,4 D  Q:$P(LA7X,"^",2)
 . . I $G(LA7HLSC(J+2))="SCT" D
 . . . S X=$O(^LAB(61,"F",LA7HLSC(J),""))
 . . . I 'X S X=+$$FINDSCT(61,LA7HLSC(J),LA7HLSC(J+1))
 . . I $G(LA7HLSC(J+2))="HL70070" S X=$O(^LAB(61,"HL7",LA7HLSC(J),0))
 . . I X>0 S $P(LA7X,"^",2)=X
 . I '$P(LA7X,"^",2),$P(^LAB(60,$P(LA7X,"^"),0),"^",4)?1(1"SP",1"CY",1"EM") D
 . . S X=$O(^LAB(61,"HL7","XXX",0))
 . . I X>0 S $P(LA7X,"^",2)=X
 ;
 ; For MI, SP, CY, and EM find first collection sample when no collection sample.
 I $P(LA7X,"^"),'$P(LA7X,"^",3),$P(^LAB(60,$P(LA7X,"^"),0),"^",4)?1(1"MI",1"SP",1"CY",1"EM") D
 . S X=""
 . F J=1,4 D  Q:$P(LA7X,"^",3)
 . . I $G(LA7HLCSC(J+2))="SCT" D
 . . . S X=$O(^LAB(62,"F",LA7HLCSC(J),""))
 . . . I 'X S X=+$$FINDSCT(62,LA7HLCSC(J),LA7HLCSC(J+1))
 . . I X>0 S $P(LA7X,"^",3)=X
 ;
 ; No urgency mapping, get last using this HL7 code or site's default urgency from #69.9
 ; Find highest non-workload urgency using this priority code else use site's default
 I '$P(LA7X,"^",4) D
 . S X=$O(^LAB(62.05,"HL7",LA7HLPRI,50),-1)
 . I X S $P(LA7X,"^",4)=X
 . E  S $P(LA7X,"^",4)=+$P($G(^LAB(69.9,1,3)),"^",2)
 ;
 ; Check file #60 forced and highest urgency.
 I $P(LA7X,"^"),$P(LA7X,"^",4) D
 . S X=$G(^LAB(60,$P(LA7X,"^"),0))
 . I $P(X,"^",18) S $P(LA7X,"^",4)=$P(X,"^",18) Q
 . I $P(X,"^",16),$P(LA7X,"^",4)<$P(X,"^",16) S $P(LA7X,"^",4)=$P(X,"^",16)
 ;
 Q LA7X
 ;
 ;
CHKCDSYS(LA7SRC,LA7DEST,LA7CSET,LA7CS) ; Check coding system order on CE/CNE/CWE data types
 ; Call with LA7SRC = source array by reference
 ;          LA7DEST = destination array by reference
 ;          LA7CSET = code set to move to primary
 ;            LA7CS = component separator
 ;
 ; Returns by reference array LA7DEST
 ;
 ; If code set in alternate then switch primary and alternate
 ;
 K LA7DEST
 ;
 I $G(LA7SRC(6))'=LA7CSET M LA7DEST=LA7SRC Q
 ;
 N J
 F J=1,2,3 D
 . S LA7DEST(J)=$G(LA7SRC(J+3)),LA7DEST(J+3)=$G(LA7SRC(J))
 . I LA7SRC'="" S $P(LA7DEST,LA7CS,J)=$P(LA7SRC,LA7CS,J+3),$P(LA7DEST,LA7CS,J+3)=$P(LA7SRC,LA7CS,J)
 S LA7DEST(7)=$G(LA7SRC(8)),LA7DEST(8)=$G(LA7SRC(7)),LA7DEST(9)=$G(LA7SRC(9))
 I $G(LA7SRC)'="" S $P(LA7DEST,LA7CS,7)=$P(LA7SRC,LA7CS,8),$P(LA7DEST,LA7CS,8)=$P(LA7SRC,LA7CS,7),$P(LA7DEST,LA7CS,9)=$P(LA7SRC,LA7CS,9)
 ;
 Q
 ;
 ;
FINDSCT(LA7FILE,LA7CODE,LA7TXT) ; Lookup SCT term in Lexicon and if possible add to target file.
 ; Call with LA7FILE = file number of target file (61/62)
 ;           LA7CODE = SCT ID
 ;            LA7TXT = SCT text
 ;
 N LA74,LA7ERROR,LAHLSEGS,LA7IEN,X,Y
 ;
 ;ZEXCEPT: LA76247,LA7CS,LA7ECH,LA7FS,LA7MID,LA7RAP,LA7RFAC,LA7SAP,LA7SFAC
 ;
 ;
 S LA74=$$RESFID^LA7VHLU2(LA7SFAC,LA7SFAC,LA7CS)
 S LAHLSEGS("R4")=LA74
 S LAHLSEGS("R6247")=$G(LA76247)
 S LAHLSEGS("FSEC")=LA7FS_LA7ECH
 S LAHLSEGS("MSH",3)=LA7SAP
 S LAHLSEGS("MSH",4)=LA7SFAC
 S LAHLSEGS("MSH",5)=LA7RAP
 S LAHLSEGS("MSH",6)=LA7RFAC
 S LAHLSEGS("MSH",11)=$G(LA7MID)
 S LAHLSEGS("OBX",3)=LA7CODE_LA7CS_LA7TXT_LA7CS_"SCT"
 ;
 S LA7IEN=$$EN^LRSCTX(LA7FILE,LA7TXT,LA7CODE,.LAHLSEGS,.LA7ERROR,0)
 ;
 Q LA7IEN
