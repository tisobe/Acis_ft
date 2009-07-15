#/usr/bin/perl
use PGPLOT;

#################################################################################
#										#
#	acis_ft_plot_week.perl: plotting routine for a week			#
#		this is a part of a csh script plotting_script			#
#	author: Takashi Isobe							#
#	March 27, 2000	first version						#
#										#
#	Last Update: Jul 15, 2009						#
#										#
#################################################################################

##############################################################################
#
#---- directory setting
#
open(FH, './dir_list');
@dir_list = ();
while(<FH>){
        chomp $_;
        push(@dir_list, $_);
}
close(FH);
$bin_dir        = $dir_list[0];
$data_dir       = $dir_list[1];
$house_keeping  = $dir_list[2];
$short_term     = $dir_list[3];
$data_out       = $dir_list[4];
$web_dir        = $dir_list[5];

##############################################################################

@today = localtime(time);                       # find today's date
$day   = $today[7];
$year  = $today[5]+ 1900;

#
#--- when was the week ago?
#
$week_ago = $day - 7;
$wday = $week_ago;
$year_wago = $year;
$this_year = $year;
if($week_ago < 1) {
	$lyear = $year -1;
	$chk = 4 * int(0.25 * $lyear);
	if($lyear == $chk){
                $week_ago += 366;
                $year_wago--;
        }else{
                $week_ago += 365;
                $year_wago--;
        }
}

open(IN, "$data_out/week_data");
@time  = ();
@avg   = ();
@dev   = ();
$count = 0;
$sum   = 0;
while(<IN>) {	
	chomp $_;
        @atemp = split(/\t/,$_);
        $year = $atemp[0];
        $day  = $atemp[1];
        $avg  = $atemp[2];

        $add = 0;
	if($year_wago < $this_year && $year == $this_year) {
                $add = 365; 
		$lyear = $year -1;
		$chk = 4 * int(0.25 * $lyear);
		if($lyear == $chk){
                        $add++;
                }
        }
	$day += $add;
        if($year >= $year_wago && $day >= $week_ago){
#
#--- remove over flow data
#
		unless( $avg > 1000 || $avg < -1000) {
			push(@time, $day);
			push(@avg, $avg);
			$sum = $sum + $avg;
			$count++;
		}
	}
}
close(IN);
#
#--- plotting starts here
#
pgbegin(0, "/ps",1,1);
pgsubp(1,1);
pgsch(2);
pgslw(4);

$xmin = $time[1];
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
system("echo ''| /opt/local/bin/gs -sDEVICE=pgmraw -sOutputFile=- -g2100x2769 -r256x256 -q pgplot.ps| $bin_dir/pnmcrop| $bin_dir/pnmscale -xsize 500| $bin_dir/ppmquant 16| $bin_dir/pnmpad -white -l20 -r20 -t20 -b20| $bin_dir/pnmflip -r270| $bin_dir/ppmtogif > $web_dir/Figs/week_plot.gif");

system("rm pgplot.ps");

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
        pglabel("Time (Day of Year)","Temp (C)", "ACIS Focal Plane Temperature (A Week)");
	pgclos();
}

