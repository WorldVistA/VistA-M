HBHCXMM ; LR VAMC(IRMS)/MJT-HBHC Transmit Medical Foster Home Data to AITC; May 21, 2021@12:36
 ;;1.0;HOSPITAL BASED HOME CARE;**24,32**;NOV 01, 1993;Build 58
 ;
 ;Reference to:
 ;   ^DG(40.8 supported by ICR #7024
 ;   ^DIC(4 supported by ICR #10090
 ;
START ; Initialization
 W !,"Processing Medical Foster Home Form 7 Data"
 N HBHCHOSPX
 S HBHCFORM=7,$P(HBHCSP4," ",5)="",$P(HBHCSP8," ",9)="",$P(HBHCS101," ",102)="",HBHCLNTH=30
 D HOSP^HBHCUTL1
LOOP ; Loop thru ^HBHC(633.2) "AC","N" cross-ref to create nodes in ^HBHC(634) => transmit or ^HBHC(634.7) => Medical Foster Home Error(s) file
 S HBHCDFN="" F  S HBHCDFN=$O(^HBHC(633.2,"AC","N",HBHCDFN)) Q:HBHCDFN=""  S HBHCFLG=1 D SETNODE I HBHCFLG D:HBHCDR="" TRANS D:HBHCDR]"" ERROR
EXIT ; Exit module
 K HBHCBEDM,HBHCCDOB,HBHCCDTS,HBHCCLOS,HBHCCNTY,HBHCDFN,HBHCDR,HBHCFLG,HBHCFORM,HBHCHOSP,HBHCIEN,HBHCINFO,HBHCLNTH,HBHCLREQ,HBHCLSDT,HBHCMFHN,HBHCMXPT,HBHCNDX1,HBHCNDX2,HBHCOPEN,HBHCREC,HBHCS101,HBHCSP4,HBHCSP8,HBHCST
 K HBHCX,HBHCXMT7,HBHCZIP,%
 Q
SETNODE ; Set node in ^HBHC(634) (Transmit) or ^HBHC(634.7) Medical Foster Home Error(s))
 S HBHCINFO=^HBHC(633.2,HBHCDFN,0),HBHCXMT7=$P($G(^HBHC(633.2,HBHCDFN,12)),U)
 ; HBHCLSDT set here to make routine freestanding if needed
 S:'$D(HBHCLSDT) HBHCLSDT=DT
 ; Quit if Opened Date is greater than HBHCLSDT (last date to include in transmit set up in ^HBHCFILE)
 I $P(HBHCINFO,U,2)>HBHCLSDT S HBHCFLG=0 Q
 S HBHCDR=""
 ;HBH*1.0*32 retrieve parent site
 D PARENT
 S HBHCMFHN=$P(HBHCINFO,U) S:$L(HBHCMFHN)<HBHCLNTH HBHCMFHN=HBHCMFHN_$J("",HBHCLNTH-$L(HBHCMFHN))
 S HBHCST=$S($P(HBHCINFO,U,10)]"":$P(^DIC(5,(+^HBHC(631.8,($P(HBHCINFO,U,10)),0)),0),U,3),1:"") S:HBHCST="" HBHCDR=HBHCDR_"9;"
 S HBHCCNTY="" S:(($P(HBHCINFO,U,10)]"")&($P(HBHCINFO,U,15)]"")) HBHCCNTY=$P($G(^DIC(5,(+^HBHC(631.8,($P(HBHCINFO,U,10)),0)),1,$P(HBHCINFO,U,15),0)),U,3) S:HBHCCNTY="" HBHCDR=HBHCDR_"25;"
 S HBHCZIP=$S($P(HBHCINFO,U,11)]"":$P(HBHCINFO,U,11),1:"") S:HBHCZIP="" HBHCDR=HBHCDR_"10;"
 I $P(HBHCINFO,U,11)]"" S:$L(HBHCZIP)'=9 HBHCZIP=HBHCZIP_HBHCSP4
 S HBHCOPEN=$S($P(HBHCINFO,U,2)]"":$E($P(HBHCINFO,U,2),4,5)_$E($P(HBHCINFO,U,2),6,7)_(1700+$E($P(HBHCINFO,U,2),1,3)),1:HBHCSP8) S:HBHCOPEN=HBHCSP8 HBHCDR=HBHCDR_"1;"
 S HBHCCDOB=$S($P(HBHCINFO,U,16)]"":$E($P(HBHCINFO,U,16),4,5)_$E($P(HBHCINFO,U,16),6,7)_(1700+$E($P(HBHCINFO,U,16),1,3)),1:HBHCSP8) S:HBHCCDOB=HBHCSP8 HBHCDR=HBHCDR_"26;"
 S HBHCMXPT=$S($P(HBHCINFO,U,4)]"":$P(HBHCINFO,U,4),1:"") S:HBHCMXPT="" HBHCDR=HBHCDR_"3;"
 S HBHCBEDM=$S($P(HBHCINFO,U,5)]"":$P(HBHCINFO,U,5),1:"") S:HBHCBEDM="" HBHCDR=HBHCDR_"4;"
 S HBHCLREQ=$S($P(HBHCINFO,U,12)]"":$P(HBHCINFO,U,12),1:"") S:HBHCLREQ="" HBHCDR=HBHCDR_"11;"
 ; HBHCCLOS represents MFH Closure Date; field may be blank
 S HBHCCLOS=$S($P(HBHCINFO,U,6)]"":$E($P(HBHCINFO,U,6),4,5)_$E($P(HBHCINFO,U,6),6,7)_(1700+$E($P(HBHCINFO,U,6),1,3)),1:HBHCSP8)
 Q:HBHCDR]""
 ; Pad HBHCDFN to length of 5, without changing HBHCDFN, since used in loop
 S:$L(HBHCDFN)<5 HBHCIEN=HBHCDFN_$J("",5-$L(HBHCDFN))
 ; HBHCCDTS (HBHC Creation Date/Time/Seconds) is used as unique record identifier on Austin end, seconds must be included for likelihood of being unique
NOW ; Get time NOW, repeat until Hours/Minutes/Seconds = 6 digits in length
 D NOW^%DTC S HBHCX=$P(%,".",2) G:($L(HBHCX)'=6) NOW S HBHCCDTS=($E(%,4,5))_($E(%,6,7))_($S($E(%)=2:19,1:20))_($E(%,2,3))_HBHCX
 ; "H" represents HBPC record origin (vs. e.g. SCI (Spinal Cord Injury) record origin)
 ;HBH*1.0*32 - replace HBHCHOSP with HBHCHOSPX in string below
 S HBHCREC=HBHCFORM_HBHCHOSPX_HBHCMFHN_HBHCCDTS_"H"_HBHCIEN_HBHCST_HBHCCNTY_HBHCZIP_HBHCCDOB_HBHCMXPT_HBHCBEDM_HBHCLREQ_HBHCOPEN_HBHCCLOS_HBHCS101
 Q
 ;
PARENT ;
 ;HBH*1.0*32 retrieve parent site
 ;If a MFH is added/edited after the install of HBH*1.0*32,
 ;a parent site must be defined for the MFH.
 ;For multidivisional sites, if parent sites were added/edited 
 ;between the time of last AITC transmission and install of
 ;HBH*1.0*32, the sites will generate HBHC Medical Foster Home Errors
 ;and will need to be edited to add a parent site.
 N HBHCPRNT
 S HBHCHOSPX=""
 S HBHCPRNT=$P($G(^HBHC(633.2,HBHCDFN,13)),"^")
 ;If site has only one parent site defined, use that site.
 I HBHCPRNT="",$P(^HBHC(631.9,1,1,0),"^",4)=1 D
 . S HBHCPRNT=$O(^HBHC(631.9,1,1,"B",""))
 I HBHCPRNT]"" D
 . ;retrieve institution file pointer for the division
 . S HBHCPRNT=$P(^DG(40.8,HBHCPRNT,0),"^",7)
 . ;retrieve station number
 . S HBHCHOSPX=$P($G(^DIC(4,+HBHCPRNT,99)),"^")
 . I HBHCHOSPX]"",$L(HBHCHOSPX)'=7 S HBHCHOSPX=HBHCHOSPX_$E(HBHCSP4,1,(7-($L(HBHCHOSPX))))
 ;If this is a multi-divisional site and the MFH does not have a parent site defined,
 ;generate error.
 I HBHCHOSPX="" S HBHCDR=HBHCDR_"35;"
 ;end of HBH*1.0*32
 Q
 ;
TRANS ; Set node in ^HBHC(634) transmit file & flag record as 'F" (filed for transmit) in ^HBHC(633.2)
 L +^HBHC(634,0):$S($D(DILOCKTM):DILOCKTM,1:3) Q:'$T  S HBHCNDX1=$P(^HBHC(634,0),U,3)+1,$P(^HBHC(634,0),U,3)=HBHCNDX1,$P(^HBHC(634,0),U,4)=$P(^HBHC(634,0),U,4)+1 L -^HBHC(634,0)
 S $P(^HBHC(634,HBHCNDX1,0),U)=HBHCREC,^HBHC(634,"B",$E(HBHCREC,1,30),HBHCNDX1)=""
 L +^HBHC(633.2,HBHCDFN,12):$S($D(DILOCKTM):DILOCKTM,1:3) Q:'$T  K:HBHCXMT7]"" ^HBHC(633.2,"AC",HBHCXMT7,HBHCDFN)
 S $P(^HBHC(633.2,HBHCDFN,12),U)="F",^HBHC(633.2,"AC","F",HBHCDFN)="",$P(^HBHC(633.2,HBHCDFN,12),U,2)=HBHCCDTS L -^HBHC(633.2,HBHCDFN,12)
 Q
ERROR ; Set node in ^HBHC(634.7) if data is incomplete
 L +^HBHC(634.7,0):$S($D(DILOCKTM):DILOCKTM,1:3) Q:'$T  S HBHCNDX2=$P(^HBHC(634.7,0),U,3)+1,$P(^HBHC(634.7,0),U,3)=HBHCNDX2,$P(^HBHC(634.7,0),U,4)=$P(^HBHC(634.7,0),U,4)+1 L -^HBHC(634.7,0)
 S ^HBHC(634.7,HBHCNDX2,0)=HBHCDFN,^HBHC(634.7,HBHCNDX2,1)=HBHCDR,^HBHC(634.7,"B",HBHCDFN,HBHCNDX2)=""
 Q
