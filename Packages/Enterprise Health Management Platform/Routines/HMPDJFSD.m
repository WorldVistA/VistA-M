HMPDJFSD ;SLC/KCM,ASMR/RRB -- Domain Lists for Extract and Freshness Stream;Oct 15, 2015 18:39:51
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;Sep 01, 2011;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; DE2818/RRB: SQA findings 1st 3 lines
 ;
 Q
 ;
PTDOMS(LIST) ; load default patient domains (put in parameter?); cpc modded order 9/29/2015
 ;;order
 ;;vital
 ;;lab
 ;;med
 ;;document
 ;;allergy
 ;;auxiliary
 ;;appointment
 ;;diagnosis
 ;;visit
 ;;factor
 ;;immunization
 ;;obs
 ;;problem
 ;;procedure
 ;;consult
 ;;image
 ;;surgery
 ;;task
 ;;ptf
 ;;exam
 ;;cpt
 ;;education
 ;;pov
 ;;skin
 ;;treatment
 ;;roadtrip
 ;;patient
 ;;zzzzz
 ;
 ;;mh
 ;
 N I,X
 F I=1:1 S X=$P($T(PTDOMS+I),";;",2,99) Q:X="zzzzz"  S LIST(I)=X
 Q
 ;
OPDOMS(LIST) ; load default operational domains (put in parameter?)
 ;;asu-class;^USR(8930)
 ;;asu-rule;^USR(8930.1)
 ;;category;^HMP(800000.11)
 ;;charttab;^HMP(800000.11)
 ;;displaygroup;^ORD(100.98)
 ;;doc-def;^TIU(8925.1)
 ;;labgroup;^LAB(64.5,1,1)
 ;;labpanel;^LAB(60)
 ;;location;^SC
 ;;orderable;^ORD(101.43)
 ;;page;^HMP(800000.11)
 ;;pt-select;^DPT
 ;;personphoto;^HMP(800000.11)
 ;;pointofcare;^HMP(800000.11)
 ;;quick;^ORD(101.41)
 ;;roster;^HMPROSTR
 ;;route;^PS(51.2)
 ;;schedule;^PS(51.1)
 ;;team;^HMP(800000.11)
 ;;teamposition;^HMP(800000.11)
 ;;user;^VA(200)
 ;;usertabprefs;^HMP(800000.11)
 ;;viewdefdef;^HMP(800000.11)
 ;;viewdefdefcoldefconfigtemplate;^HMP(800000.11)
 ;;immunization;^AUTTIMM
 ;;allergy-list;^GMRD(120.82)
 ;;sign-symptom;^GMRD(120.83)
 ;;vital-type;^GMRD(120.51)
 ;;vital-qualifier;^GMRD(120.52)
 ;;vital-category;^GMRD(120.53)
 ;;zzzzz
 ;
 ;;problem-list;^LEX(757.01)
 ;;clioterminology
 ;;doc-action
 ;;doc-status
 ;
 N I,X
 F I=1:1 S X=$P($T(OPDOMS+I),";",3) Q:X="zzzzz"  S LIST(I)=X
 Q
 ;
