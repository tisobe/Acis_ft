#!/usr/bin/env /usr/local/bin/perl
use PGPLOT;

#################################################################################
#										#
#	acis_ft_plot_month.perl: plotting month long fp temp			#
#		this is a part of a csh script: plotting_script			#
#	author: Takashi Isobe							#
#	March 14, 2000	first version						#
#										#
#	Last Update: Apr 16, 2013						#
#										#
#################################################################################
#
#--- check whether this is a test
#
$comp_test = $ARGV[0];
chomp $comp_test;

##############################################################################
#
#---- directory setting
#
if($comp_test =~ /test/i){
	$dir_list = '/data/mta/Script/ACIS/Focal/house_keeping/dir_list_test';
}else{
	$dir_list = '/data/mta/Script/ACIS/Focal/house_keeping/dir_list';
}
open(FH, $dir_list);
while(<FH>){
    chomp $_;
    @atemp = split(/\s+/, $_);
    ${$atemp[0]} = $atemp[1];
}
close(FH);
##############################################################################


if($comp_test =~ /test/i){
	@today =  (0, 0, 0, 24, 1, 113, 1, 56, 0);
}else{
	@today = localtime(time);                       # find today's date
}
$day   = $today[7];
$year  = $today[5] + 1900;
#
#--- when was the month ago?
#
$month_ago = $day - 30;
$mday      = $month_ago;
$year_mago = $year;
$this_year = $year;
if($month_ago < 1) {
	$lyear = $year -1;
	$chk   = 4 * int(0.25 * $lyear);
	if($lyear == $chk){
                $month_ago += 366;
                $year_mago--;
        }else{
                $month_ago += 365;
                $year_mago--;
        }
}

open(IN,"$data_out/month_data");
@time  = ();
@avgi  = ();
@dev   = ();
$count = 0;
$sum   = 0;
while(<IN>) {
	chomp $_;
        @atemp = split(/\t/,$_);
        $year  = $atemp[0];
        $day   = $atemp[1];
        $avg   = $atemp[2];

        $add = 0;
	if($year_mago < $this_year && $year == $this_year){
                $add   = 365; 
		$lyear = $year -1;
		$chk   = 4 * int(0.25 * $lyear);
		if($lyear == $chk){
                        $add++;
                }
        }
        $day += $add;

        if($year >= $year_mago && $day >= $month_ago){
#
#--- exclude over flow data
#
		unless( $avg > 1000 || $avg < -1000) {
			push(@time, $day);
			push(@avg, $avg);
			push(@dev, $dev);
			$sum = $sum + $avg;
			$count++;
		}
	}
}
close(IN);
#
#--- plot starts here
#
pgbegin(0, "/ps",1,1);
pgsubp(1,1);	
pgsch(2);
pgslw(4);

$xmin = $time[0];
$xmax = $time[$count-2];
$cent = $sum/$count;
@temp = sort{$a<=>$b} @avg;
@temp = reverse(@temp);
OUTER:
foreach $ent (@temp) {
	if($ent < -80) {
		$ymax = $ent+1;
		last OUTER;
	}
}
$ymin = $temp[$count-4]- 2;
#
#--- plotting sub
#
plot_fig();
#
#--- changing a ps-file to a gif-file
#
system("echo ''| gs -sDEVICE=pgmraw -sOutputFile=- -g2100x2769 -r256x256 -q pgplot.ps|  pnmscale -xsize 500| ppmquant 16| pnmpad -white -left=20 -right=20 -top=20 -bottom=20| pnmflip -r270| ppmtogif > $web_dir/Figs/month_plot.gif");

system("rm -rf pgplot.ps");


##################################
### plot_fig: plotting routine ###
##################################

sub plot_fig {

        pgenv($xmin, $xmax, $ymin, $ymax, 0, 0);

        pgpt(1, $time[0], $avg[0], -1);                # plot a point (x, y)
        for($m = 1; $m < $count-1; $m++) {
                unless($avg[$m] eq '*****' || $avg[$m] eq ''){
                        pgpt(1,$time[$m], $avg[$m], -2);
                }
        }
        pglabel("Time (Day of Year)","Temp (C)", "ACIS Focal Plane Temperature (Month Plot)");
	pgclos();
}

