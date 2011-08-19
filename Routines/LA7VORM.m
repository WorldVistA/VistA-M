LA7VORM ;DALOI/DLR - LAB ORM (Order) message PROCESSOR ; April 13, 2004
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27,42,46,64**;Sep 27, 1994
IN ;
 D ORM^LA7VHL
 Q
 ;
OBR ;;OBR
 N LA760,LA76205,LA7629,LA7ACC,LA7CEDT,LA7CSCS,LA7CSNM,LA7CSTY,LA7DCODE,LA7HSITE,LA7I,LA7NCS,LA7OTST,LA7OTSTN,LA7PF1,LA7PF2,LA7RCI,LA7SPCS,LA7SPNM,LA7SPTY,LA7USID,LA7X,LA7Y,RTST,RTSTN
 ;
 ; OBR Set ID
 S LA7SOBR=$$P^LA7VHLU(.LA7SEG,2,LA7FS)
 ;
 ; Placer order number
 S LA7SID=$$P^LA7VHLU(.LA7SEG,3,LA7FS)
 ;
 ; Universal service ID
 S LA7USID=$$P^LA7VHLU(.LA7SEG,5,LA7FS)
 S LA7OTSTN=$P(LA7USID,LA7CS)
 I LA7OTSTN="" D  Q
 . N LA7X
 . S LA7X="PID-"_LA7SPID_"/OBR-"_LA7SOBR
 . D CREATE^LA7LOG(26)
 ;
 S LA7OTST=$$UNESC^LA7VHLU3($P(LA7USID,LA7CS,2),LA7FS_LA7ECH)
 S LA7NCS=$P(LA7USID,LA7CS,3) ; Name of coding system
 S RTSTN=$P(LA7USID,LA7CS,4)
 S RTST=$$UNESC^LA7VHLU3($P(LA7USID,LA7CS,5),LA7FS_LA7ECH)
 ;
 ; No ORC segment
 I LA7SEQ<20 D  Q
 . D CREATE^LA7LOG(29)
 ;
 ; Missing patient name
 I $G(LA7PNM)="" D  Q
 . D CREATE^LA7LOG(30)
 ;
 ; Non-VA system, not using NLT codes/file #60 tests
 I LA7NCS'="99VA64" D
 . I RTSTN="" S RTSTN=LA7OTST
 . I RTST="" S RTST=LA7OTSTN
 ;
 ; Specimen collection date/time
 S LA7CDT=$$HL7TFM^XLFDT($P($$P^LA7VHLU(.LA7SEG,8,LA7FS),LA7CS),"L")
 ;
 ; Specimen end collection date/time (timed collection)
 S LA7CEDT=$$HL7TFM^XLFDT($P($$P^LA7VHLU(.LA7SEG,9,LA7FS),LA7CS),"L")
 ;
 ; Collection volume
 S LA7VOL=""
 S LA7X=$$P^LA7VHLU(.LA7SEG,10,LA7FS)
 I $L($P(LA7X,LA7CS)) D
 . S $P(LA7VOL,"^")=$P(LA7X,LA7CS) ; volume
 . S $P(LA7VOL,"^",2)=$P(LA7X,LA7CS,2) ; volume units
 . S $P(LA7VOL,"^",3)=$P(LA7X,LA7CS,3) ; volume coding system
 ;
 ; Specimen action code
 S LA7X=$$P^LA7VHLU(.LA7SEG,12,LA7FS),LA7SAC=""
 I LA7X="A" S LA7SAC="Add ordered tests to the existing specimen"
 I LA7X="G" S LA7SAC="Generated order; reflex order"
 ;
 ; Danger code
 S LA7X=$P($$P^LA7VHLU(.LA7SEG,13,LA7FS),LA7CS,2)
 S LA7DCODE=$$UNESC^LA7VHLU3(LA7X,LA7FS_LA7ECH)
 I LA7DCODE]"" D
 . S LA7DCODE=$$TRIM^XLFSTR(LA7DCODE,"RL"," ")
 . S LA7DCODE="Danger Code - "_LA7DCODE
 ;
 ; Relevant clinical information
 S LA7X=$$P^LA7VHLU(.LA7SEG,14,LA7FS)
 S LA7RCI=$$UNESC^LA7VHLU3(LA7X,LA7FS_LA7ECH)
 I LA7RCI]"" D
 . S LA7RCI=$$TRIM^XLFSTR(LA7RCI,"RL"," ")
 . S LA7RCI="Relevant clinical information - "_LA7RCI
 ;
 ; Specimen source -  specimen code - name of specimen coding system
 ; If no primary then try alternate
 S LA7X=$$P^LA7VHLU(.LA7SEG,16,LA7FS)
 S LA7SPTY=$P($P(LA7X,LA7CS),$E(LA7ECH,4))
 S LA7SPNM=$P($P(LA7X,LA7CS),$E(LA7ECH,4),2)
 S LA7SPCS=$P($P(LA7X,LA7CS),$E(LA7ECH,4),3)
 I LA7SPTY="" D
 . S LA7SPTY=$P($P(LA7X,LA7CS),$E(LA7ECH,4),4)
 . S LA7SPNM=$P($P(LA7X,LA7CS),$E(LA7ECH,4),5)
 . S LA7SPCS=$P($P(LA7X,LA7CS),$E(LA7ECH,4),6)
 ;
 ; Collection sample from body site
 S LA7CSTY=$P($P(LA7X,LA7CS,4),$E(LA7ECH,4))
 S LA7CSNM=$P($P(LA7X,LA7CS,4),$E(LA7ECH,4),2)
 S LA7CSCS=$P($P(LA7X,LA7CS,4),$E(LA7ECH,4),3)
 ;
 ; Placer's ordering provider (last name, first name, mi [id])
 ; Only process if LA7POP from ORC-12 is blank.
 I LA7POP="" D
 . S LA7X=$$P^LA7VHLU(.LA7SEG,17,LA7FS)
 . S LA7POP=$$XCNTFM^LA7VHLU4(LA7X,LA7ECH)
 . I LA7POP="^^" S LA7POP=""
 ;
 ; Specimen urgency
 S LA7UR=$P($$P^LA7VHLU(.LA7SEG,28,LA7FS),LA7CS,6)
 ; If no urgency see if it came in ORC-7
 I LA7UR="" S LA7UR=$G(LA7OUR)
 ;
 ; Look for receiving facility in OBR, then use receiving facility from MSH
 S LA7X=$P($$P^LA7VHLU(.LA7SEG,35,LA7FS),LA7CS,7)
 S LA7HSITE=$$FINDSITE^LA7VHLU2(LA7X,1,1)
 I LA7HSITE'>0 S LA7HSITE=$$FINDSITE^LA7VHLU2(LA7RFAC,1,0)
 ;
 ; Find an "active" shipping configuration for this pair.
 S LA7629=0
 I LA7CSITE,LA7HSITE D
 . N LA7X
 . S LA7X=0
 . F  S LA7X=$O(^LAHM(62.9,"CH",LA7CSITE,LA7HSITE,LA7X)) Q:'LA7X  I $P($G(^LAHM(62.9,LA7X,0)),"^",4) S LA7629=LA7X Q
 ; Log error and quit if no active shipping configuration identified
 I 'LA7629 D  Q
 . D CREATE^LA7LOG(39)
 ;
 S LA7Y=$$DTTO^LA7SMU2(LA7629,LA7OTSTN,LA7SPTY,LA7NCS,LA7SPCS,LA7UR,LA7CSTY_"^"_LA7CSNM_"^"_LA7CSCS)
 S LA760=$P(LA7Y,"^"),LA761=$P(LA7Y,"^",2),LA762=$P(LA7Y,"^",3),LA76205=$P(LA7Y,"^",4)
 I $P(LA7Y,"^",5)'="" S LA7OTSTN=$P(LA7Y,"^",5),LA7OTST=$P(LA7Y,"^",6)
 F LA7I=1:1:4 I '$P(LA7Y,"^",LA7I) D
 . I LA7I=3,LA760,"MISPCYEM"[$P(^LAB(60,LA760,0),"^",4) Q
 . S LA7X="No local "_$P("lab test^topography^collection sample^urgency","^",LA7I)_" mapped."
 . N LA7I,LA7Y
 . D CREATE^LA7LOG(47)
 ;
 ; Placer fields 1 & 2
 S LA7X=$$P^LA7VHLU(.LA7SEG,19,LA7FS)
 I LA7X'="",LA7X[LA7CS S LA7X=$TR(LA7X,LA7CS,"^")
 S LA7PF1=$$UNESC^LA7VHLU3(LA7X,LA7FS_LA7ECH)
 S LA7X=$$P^LA7VHLU(.LA7SEG,20,LA7FS)
 I LA7X'="",LA7X[LA7CS S LA7X=$TR(LA7X,LA7CS,"^")
 S LA7PF2=$$UNESC^LA7VHLU3(LA7X,LA7FS_LA7ECH)
 S LA7ACC=$P(LA7PF2,"^",6)
 ;
 ; New order - add to LAB PENDING ORDERS file #69.6
 I LA7OTYPE="NW" D NW
 ;
 Q
 ;
NW ; Create new order in LAB PENDING ORDERS file #69.6
 ;
 N FDA,I,LA76964,LA7DIE,LA7I,LA7IEN,LA7PATID,LA7SSITE,LA7STAT,LA7WP
 ;
 ; Get lock on 69.6
 L +^LRO(69.6,0):99999
 I '$T D  Q
 . D CREATE^LA7LOG(31)
 ;
 S LA7696=$O(^LRO(69.6,"AD",$S($P(LA7SM,"^",2)'="":$P(LA7SM,"^",2),1:0),LA7SID,0))
 ;
 ; Find "In-Transit" status in #64.061
 S LA7STAT=$$FIND1^DIC(64.061,"","OMX","In-Transit","","I $P(^LAB(64.061,Y,0),U,7)=""U""")
 ;
 ; Create entry in LAB PENDING ORDER ENTRY file, log error if not added
 I $G(LA7696)'>0 D
 . S FDA(1,69.6,"+1,",.01)=LA7PNM
 . S FDA(1,69.6,"+1,",6)=LA7STAT
 . D UPDATE^DIE("","FDA(1)","LA7IEN","LA7DIE(1)")
 . S LA7696=LA7IEN(1)
 . I LA7696<1 D CREATE^LA7LOG(32)
 ;
 L -^LRO(69.6,0)
 I LA7696<1 Q
 ;
 L +^LRO(69.6,LA7696):99999
 I '$T D  Q  ;cannot get lock on ENTRY in 69.6
 . D CREATE^LA7LOG(33)
 ;
 ; Prevent duplication of tests
 I $D(^LRO(69.6,LA7696,2,"C",LA7OTSTN)) D UNLOCK Q
 ;
 ; Determine entry in INSTITUTION file (#4) that's the sending site.
 S LA7SSITE=$$FINDSITE^LA7VHLU2(LA7SFAC,2,0)
 ;
 ; Patient id to store with order
 S LA7PATID=LA7SSN
 I LA7PATID="" D
 . S LA7PATID=$P($G(LA7PTID3(1)),$E(LA7ECH))
 . I LA7PATID'="" Q
 . I LA7PTID4'="" S LA7PATID=$P($P(LA7PTID4,$E(LA7ECH,2)),$E(LA7ECH))
 . I LA7PATID'="" Q
 . I LA7PTID2'="" S LA7PATID=$P(LA7PTID2,$E(LA7ECH))
 ;
 S FDA(2,69.6,LA7696_",",.01)=LA7PNM
 S FDA(2,69.6,LA7696_",",.02)=LA7SEX
 S FDA(2,69.6,LA7696_",",.03)=LA7DOB
 I $G(LA7PRACE)'="" S FDA(2,69.6,LA7696_",",.06)=LA7PRACE
 S FDA(2,69.6,LA7696_",",.09)=LA7PATID
 S FDA(2,69.6,LA7696_",",1)=LA7SSITE
 S FDA(2,69.6,LA7696_",",2)=LA7CSITE
 S FDA(2,69.6,LA7696_",",3)=LA7SID
 S FDA(2,69.6,LA7696_",",3.2)=LA7ACC
 I LA761 S FDA(2,69.6,LA7696_",",4)=LA761
 I LA762 S FDA(2,69.6,LA7696_",",5)=LA762
 S FDA(2,69.6,LA7696_",",10)=LA7ORDT
 S FDA(2,69.6,LA7696_",",11)=LA7CDT
 S FDA(2,69.6,LA7696_",",11.1)=LA7CEDT
 S FDA(2,69.6,LA7696_",",14)=LA7MEDT
 S FDA(2,69.6,LA7696_",",17)=LA7MID
 I $P(LA7SM,"^",2)'="" S LA7X=$P(LA7SM,"^",2)
 E  S LA7X=LA7SFAC_"-"_$E($$FMTHL7^XLFDT(LA7MEDT),1,8)
 S FDA(2,69.6,LA7696_",",18)=LA7X
 S FDA(2,69.6,LA7696_",",700)=LA7FS_LA7ECH
 I LA7PTID3'="" S FDA(2,69.6,LA7696_",",700.02)=LA7PTID3
 I LA7PTID4'="" S FDA(2,69.6,LA7696_",",700.04)=LA7PTID4
 D FILE^DIE("","FDA(2)","LA7DIE(2)")
 ;
 ; Add test to order
 S FDA(3,69.64,"+2,"_LA7696_",",.01)=LA7OTST
 S FDA(3,69.64,"+2,"_LA7696_",",1)=LA7OTSTN
 S FDA(3,69.64,"+2,"_LA7696_",",2)=RTST
 S FDA(3,69.64,"+2,"_LA7696_",",3)=RTSTN
 S FDA(3,69.64,"+2,"_LA7696_",",4)=LA7UR
 I LA760 S FDA(3,69.64,"+2,"_LA7696_",",11)=LA760
 I LA76205 S FDA(3,69.64,"+2,"_LA7696_",",12)=LA76205
 I $P(LA7POP,"^",3)'="" S FDA(3,69.64,"+2,"_LA7696_",",13)=$P(LA7POP,"^",3)
 I LA7USID'="" S FDA(3,69.64,"+2,"_LA7696_",",700.04)=LA7USID
 I LA7PF1'="" S FDA(3,69.64,"+2,"_LA7696_",",700.18)=LA7PF1
 I LA7PF2'="" S FDA(3,69.64,"+2,"_LA7696_",",700.19)=LA7PF2
 D UPDATE^DIE("","FDA(3)","LA76964","LA7DIE(3)")
 ;
 ; If no test status - set to In-transit.
 I $G(LA76964(2)),$P($G(^LRO(69.6,LA7696,2,LA76964(2),0)),"^",6)="" D
 . S FDA(4,69.64,LA76964(2)_","_LA7696_",",5)=LA7STAT
 . D FILE^DIE("","FDA(4)","LA7DIE(4)")
 ;
 ; Check for comments to store with order.
 ; Begin sections with <space> to avoid FM word wrap.
 S LA7I=1
 I 'LA760 S LA7WP(LA7I,0)="For test "_LA7OTST
 E  S LA7WP(LA7I,0)="For test "_$$GET1^DIQ(60,LA760_",",.01)
 ;
 I LA7SAC'="" S LA7I=LA7I+1,LA7WP(LA7I,0)=" "_LA7SAC
 ;
 I LA7DCODE'="" F I=1:250:$L(LA7DCODE) S LA7I=LA7I+1,LA7WP(LA7I,0)=$S(I=1:" ",1:"")_$E(LA7DCODE,I,I+249)
 ;
 I LA7RCI'="" F I=1:250:$L(LA7RCI) S LA7I=LA7I+1,LA7WP(LA7I,0)=$S(I=1:" ",1:"")_$E(LA7RCI,I,I+249)
 ;
 I LA760,"MISPCYEM"[$P(^LAB(60,LA760,0),"^",4) D
 . S LA7I=LA7I+1,LA7WP(LA7I,0)=" Specimen source: "_LA7SPNM_" ["_LA7SPCS_": "_LA7SPTY_"]"
 . S LA7I=LA7I+1,LA7WP(LA7I,0)=" Collection sample: "_LA7CSNM_" ["_LA7CSCS_": "_LA7CSTY_"]"
 ;
 I $O(LA7WP(1)) D WP^DIE(69.6,LA7696_",",99,"A","LA7WP","LA7DIE(99)")
 ;
 D CLEAN^DILF
 D UNLOCK
 Q
 ;
UNLOCK ; unlock entry in file #69.6
 L -^LRO(69.6,LA7696)
 Q
