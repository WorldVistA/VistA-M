HBHCEDSP ; LR VAMC(IRMS)/MJT-HBHC Edit System Parameters => Edit Number of Visit Days to Scan & Transmit Report Printer fields in 631.9 ;9205
 ;;1.0;HOSPITAL BASED HOME CARE;**6,8**;NOV 01, 1993
 K DIE S DIE="^HBHC(631.9,",DA=1,DR="3;6" D ^DIE
 K DA,DIE,DR,X,Y
 Q
