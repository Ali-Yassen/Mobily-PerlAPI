### Mobily.ws Perl API v0.1
### by Ali Al-Yassen 2/2012
### me3reich@gmail.com
use LWP::UserAgent;
require 'Unicode.pm';
use strict;
use utf8;

my $agent = LWP::UserAgent->new();

sub sendStatus{
my $resultType = shift // 1;
my $url = "http://www.mobily.ws/api/sendStatus.php";
my $dispatcher = $agent->get( $url );
my $response = $dispatcher->content;
my @results = ("You can send now","You can't send now");
if ($resultType != 0){
	return $results[0] if ($response == 1);
	return $results[1] if ($response != 1);
	}
else {return $response }
}

sub changePassword{	
my ($mobile, $password, $newpassword, $resultType) = @_;
my $url = "http://www.mobily.ws/api/changePassword.php";
my $dispatcher = $agent->post( $url, {mobile => $mobile, password => $password, newPassword => $newpassword});
my $response =  $dispatcher->content;
my @results = ("No such Mobile Number","Current password is wrong","Password changed successfully");
if ($resultType != 0){
	return $results[0] if ($response == 1);
	return $results[1] if ($response == 2);
	return $results[2] if ($response == 3);
	}
else {return $response }
}

sub balance {
		my ($mobile, $password, $resultType) = @_;
		my $url = "http://www.mobily.ws/api/balance.php";
		my $dispatcher = $agent->post( $url, {mobile => $mobile, password => $password});
		my $response =  $dispatcher->content;
		my @results = ("Mobile Number is not correct","Password is not correct",
		"Your balance is : $response");
		if ($resultType != 0){
		return $results[0] if ($response == 1);
		return $results[1] if ($response == 2);
		return $results[2] if ($response);		
		}
else {return $response } 	
}

sub forgetPassword{
	my ($mobile, $type, $resultType) = @_;
	my $url = "http://www.mobily.ws/api/forgetPassword.php";
	my $dispatcher = $agent->post( $url, {mobile => $mobile, type => $type});
	my $response =  $dispatcher->content;
	my @results = ("Mobile number is not valid","Email is not provided",
	"Successfully sent password to mobile", "You don't have enough balance"
	,"Success! Password sent to email","The email account is not valid",
	"The account number used is not valid");
	if ($resultType != 0){
	return $results[0] if ($response == 1);
	return $results[1] if ($response == 2);
	return $results[2] if ($response == 3);
	return $results[3] if ($response == 4);
	return $results[4] if ($response == 5);
	return $results[5] if ($response == 6);
	return $results[6] if ($response == 7);
	}
else {return $response }
	}

sub sendSMS{
	my ($mobile, $password, $numbers, $sender, $msg, $timeSend, $dateSend, $deleteKey, $resultType ) = @_;		
	my $ucs2 = convertToUnicode($msg);
	my $url = "http://www.mobily.ws/api/msgSend.php";
	my $dispatcher = $agent->post( $url, {mobile => $mobile, password => $password, numbers=>$numbers,
	 sender =>$sender,msg =>$ucs2,timeSend => $timeSend,dateSend => $dateSend, deleteKey => $deleteKey,
	applicationType => 24});
	if ($dispatcher->is_success){	
	 my $response =  $dispatcher->content;
	my @results = ("Couldn't connect to server","No connection to database","Sent successfully","Balance = 0",
	"Balance is not enough","Mobile number not found","Wrong Password","Inactive webpage, try again later.",
	"Name of sender is not valid","Name of sender is not known","Unvalid numbers to send",
	"Empty sender name","The message encoding is not valid");
		if ($resultType != 0){
		return $results[0] if ($response == -2); 
		return $results[1] if ($response == -1);
		return $results[2] if ($response == 1);
		return $results[3] if ($response == 2);
		return $results[4] if ($response == 3);
		return $results[5] if ($response == 4);
		return $results[6] if ($response == 5);
		return $results[7] if ($response == 6);
		return $results[8] if ($response == 13);
		return $results[9] if ($response == 14);
		return $results[10] if ($response == 15);
		return $results[11] if ($response == 16);
		return $results[12] if ($response == 17);
	}
else {return $response }
}
else {die $dispatcher->status_line;}
}
	
sub deleteMsg{
	my ($mobile, $password, $deleteKey, $resultType) = @_;
	my $url = "http://www.mobily.ws/api/deleteMsg.php";
	my $dispatcher = $agent->post( $url, {mobile => $mobile, password => $password, deleteKey => $deleteKey});
	my $response =  $dispatcher->content;
	my @results = ("Deletion successful", "Mobile number not valid","Password wrong","DeleteKey is wrong");	
	if ($resultType != 0){
	return $results[0] if ($response == 1);
	return $results[1] if ($response == 2);
	return $results[2] if ($response == 3);
	return $results[3] if ($response == 4);
	}
	else {return $response }
	}	

sub addAlphaSender{
	my ($mobile, $password, $sender, $resultType) = @_;
	my $url = "http://www.mobily.ws/api/addAlphaSender.php";
	my $dispatcher = $agent->post( $url, {mobile => $mobile, password => $password, sender => $sender});
	my $response =  $dispatcher->content;
	my @results = ("Mobile number is not valid", "Password wrong","Sender name is more than 11 chars","Added successfully");
	if ($resultType != 0){
	return $results[0] if ($response == 1);
	return $results[1] if ($response == 2);
	return $results[2] if ($response == 3);
	return $results[3] if ($response == 4);
	}
	else {return $response }
	}	

sub checkAlphasSender{
	my ($mobile, $password, $resultType) = @_;
	my $url = "http://www.mobily.ws/api/checkAlphasSender.php";
	my $dispatcher = $agent->post( $url, {mobile => $mobile, password => $password});
	my $response =  $dispatcher->content;
	my @results = ("Mobile number is not valid", "Password wrong","$response");
	if ($resultType != 0){
	return $results[0] if ($response == 1);
	return $results[1] if ($response == 2);
	return $results[2] if ($response);
	}
	else {return $response }
	}	

1;





