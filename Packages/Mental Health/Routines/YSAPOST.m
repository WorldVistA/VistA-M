YSAPOST ;DALIRMFO/MJD-EDIT MH INSTRUMENT (601) DATA ; 1/29/96
 ;;5.01;MENTAL HEALTH;**10**;Dec 30, 1994
 ;
EN ;
 ; This sets field #6 - ^YTT(601,75,"A")
 N DA,DIE,DR,X,Y
 S DIE="^YTT(601,",DA=75
 S DR="6////D ^YTDRIV S YSEN=YSTEST,X=$G(^YTD(601.2,YSDFN,1,+YSEN,1,YSHD,1)),YSXX="""" F YSJXTP=1:1:25 S YSXX=YSXX_($E(X,YSJXTP)-1) S:YSJXTP=25 ^YTD(601.2,YSDFN,YSEN,1,YSHD,1)=YSXX"
 D ^DIE
 ;
177 ; This sets field #22 - The 11th piece of the zero node of ^YTT(601,201
 N DA,DIE,DR,X,Y
 S DIE="^YTT(601,",DA=201,DR="22////177" D ^DIE
 ;
202 ; This sets field #2 of the multiple 601.2
 N DA,DIE,DR,X,Y
 S DIE="601",DA=202
 S DR="1///274"
 S DR(2,601.02)="2///I am so touchy on some subjects that I can't talk about them."
 D ^DIE
 ;
105 ; This sets field #5 of the multiple 601.2
 N DA,DIE,DR,X,Y
 S DIE="601",DA=105
 S DR="1///181"
 S DR(2,601.02)="5///3,8"
 D ^DIE
 K DA,DIE,DR,X,Y
 QUIT
