IBQLPRE ;LEB/MRY - PRE INSTALL INIT ; 7-JUL-95
 ;;1.0;UTILIZATION MGMT ROLLUP LOCAL;;Oct 01, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;Check DUZ and DUZ(0)
 I $S('($D(DUZ)#2):1,'($D(DUZ(0))#2):1,'DUZ:1,1:0) W *7,!!,"***   DUZ and DUZ(0) must be defined as a valid user to initialize.   ***",!!  K DIFQ Q
 I DUZ(0)'="@" W *7,!!,"You must have programmer access (DUZ(0)='@') before running IBQLINIT.",!! K DIFQ Q
 ;
 ;Check for version of Integrated Billing. If IB is installed, must be version 2.0.
 S X=+$$VERSION^XPDUTL("IB") I X<2 D  Q
 .W *7,!,"You must have Integrated Billing Version 2.0 installed prior to installing Utilization Management Rollup version 1.0T.",! K DIFQ
 ;
 ;Check for version of Mailman, If XM is installed, must be version 7.1.
 S X=+$$VERSION^XPDUTL("XM") I X<7.1 D
 .W *7,!,"You must have Mailman Version 7.1 installed prior to installing Utilization Management Rollup version 1.0T.",! K DIFQ
 Q
