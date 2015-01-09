use strict;
use vars qw($VERSION %IRSSI);
#use Data::Dumper;
#local $Data::Dumper::Terse = 1;

use Irssi;
$VERSION = '0.0.4';
%IRSSI = (
	name => 'fnotify',
	authors => 'James Shubin',
	contact => 'https://ttboj.wordpress.com/contact/',
	url => 'https://ttboj.wordpress.com/',
	description => 'Write notifications to a file in a consistent format.',
	license => 'Affero GNU General Public License 3+',
	changed => '$Date: 2013-10-13 12:00:00 +0500 (Thu, 17 Oct 2013) $'
);

#
#	README
#
# To use:
# $ cp fnotify.pl ~/.irssi/scripts/fnotify.pl
# irssi> /load perl
# irssi> /script load fnotify
#

#
#	AUTHORS
#
# Consistent output formatting by James Shubin:
# https://ttboj.wordpress.com/
#
# Modified from the Thorsten Leemhuis <fedora@leemhuis.info> version:
# http://www.leemhuis.info/files/fnotify/fnotify
#
# In parts based on knotify.pl 0.1.1 by Hugo Haas:
# http://larve.net/people/hugo/2005/01/knotify.pl
#
# Which is based on osd.pl 0.3.3 by Jeroen Coekaerts, Koenraad Heijlen:
# http://www.irssi.org/scripts/scripts/osd.pl
#
# Other parts based on notify.pl from Luke Macken:
# http://fedora.feedjack.org/user/918/
#

#
#	catch private messages
#
sub priv_msg {
	my ($server, $msg, $nick, $address, $target) = @_;
	#filewrite($nick . ' ' . $msg);
	#my $test = Dumper($server);
	my $network = $server->{tag};
	filewrite('' . $network . ' ' . $nick . ' ' . $msg);
}

#
#	catch 'hilight's
#
sub hilight {
	my ($dest, $text, $stripped) = @_;
	if ($dest->{level} & MSGLEVEL_HILIGHT) {
		#filewrite($dest->{target} . ' ' . $stripped);
		#my $test = Dumper($dest);
		my $server = $dest->{server};
		my $network = $server->{tag};
		filewrite($network . ' ' . $dest->{target} . ' ' . $stripped);
	}
}

#
#	write to file
#
sub filewrite {
	my ($text) = @_;
	# FIXME: there is probably a better way to get the irssi-dir...
	open(FILE, ">>$ENV{HOME}/.irssi/fnotify");
	print FILE $text . "\n";
	close(FILE);
}

#
#	irssi signals
#
Irssi::signal_add_last("message private", "priv_msg");
Irssi::signal_add_last("print text", "hilight");

