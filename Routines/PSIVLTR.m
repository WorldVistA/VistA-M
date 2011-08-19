PSIVLTR ;BIR/PR-BUILD LABEL TRACKER FOR ACTIVITY LOG ; 15 May 98 / 9:27 AM
 ;;5.0; INPATIENT MEDICATIONS ;**3**;16 DEC 97
 ;This routine needs the following parameters:
 ;TRACK - only defined if label action is dispensed or suspended
 ;        1=Ind lbs, 2=Sched lbs, 3= Sus lbs, 4= Order act lab
 ;ACTION - What is being done with the labels
 ;1=Dispensed, 2=Recycled, 3=Destroyed, 4=Cancelled, 5=Suspended
 ;PSIVNOL- number of labels being acted on
 ;DFN - Patient
 ;ON - Order number
 ;L +^PS(55,DFN,"IV",0)
 S:'$D(^PS(55,DFN,"IV",+ON,"LAB",0)) ^(0)="^55.1111^^" S N=^(0)
 F DA=$P(N,U,3)+1 I '$D(^PS(55,DFN,"IV",+ON,"LAB",DA)) S $P(N,U,3)=DA,$P(N,U,4)=$P(N,U,4)+1,^PS(55,DFN,"IV",+ON,"LAB",0)=N Q
 D NOW^%DTC D @ACTION G K
 ;
1 ;Dispensed
 S J=DA_U_%_U_ACTION_U_DUZ_U_PSIVNOL_U_TRACK_U_$S('$D(PSIVCT):1,1:0),^PS(55,DFN,"IV",+ON,"LAB",DA,0)=J
 Q
 ;
2 ;Recycled
 S J=DA_U_%_U_ACTION_U_DUZ_U_PSIVNOL D ERROR S ^PS(55,DFN,"IV",+ON,"LAB",DA,0)=J
 Q
3 ;Destroyed
 S J=DA_U_%_U_ACTION_U_DUZ_U_PSIVNOL D ERROR S ^PS(55,DFN,"IV",+ON,"LAB",DA,0)=J
 Q
4 ;Cancelled
 S J=DA_U_%_U_ACTION_U_DUZ_U_PSIVNOL D ERROR S ^PS(55,DFN,"IV",+ON,"LAB",DA,0)=J
 Q
5 ;Suspended
 S J=DA_U_%_U_ACTION_U_DUZ_U_PSIVNOL_U_TRACK,^PS(55,DFN,"IV",+ON,"LAB",DA,0)=J
 Q
ERROR ;Set piece 8 if user is in the wrong IV room.
 I $D(E)&($D(E1)) S $P(J,U,8)=E1_" "_E
 Q
K ;
 ;L -^PS(55,DFN,"IV",0) K DA,J,%,N,TRACK,ACTION
 K DA,J,%,N,TRACK,ACTION
 Q
