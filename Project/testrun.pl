use GroceryStore;
use Items;
use Data::Dumper;

my $storeobject = GroceryStore->new();

#Employee Registration
$storeobject->UserRegister({
	USERNAME => 'Nive',
	PASSWORD => '123',
	ISADMIN => 0,
	ISEMPLOYEE => 1
});

#Login 
my $message = $storeobject->Login({
	USERNAME => 'Nive',
	PASSWORD => '456',
});
print "$message for User $storeobject->{CREDENTIAL}{USERNAME}\n";

#Chech if a user is an Admin
my $isadmin = $storeobject->IsAdmin({
	USERNAME => 'Nive',
});
print $storeobject->{CREDENTIAL}{USERNAME} . " is a Admin\n" if ($isadmin);

#Admin Registration
$storeobject->UserRegister({
	USERNAME => 'Priya',
	PASSWORD => '123',
	ISADMIN => 1,
	ISEMPLOYEE => 1,
});
$message = $storeobject->Login({
	USERNAME => 'Priya',
	PASSWORD => '123'
});
print "$message $storeobject->{CREDENTIAL}{USERNAME}\n";
my $admin = $storeobject->IsAdmin({
	USERNAME => 'Priya',
});
print "$storeobject->{CREDENTIAL}{USERNAME} is a Admin\n" if ($admin);
#Initialize items into the Inventory
my @items = ('Vegetables','Fruits','Spices','Cookies');
my $returnvalue = $storeobject->AddItems({
	USERNAME => 'Priya',
	ITEMS => \@items
});

print "$returnvalue\n";
#Enter Product details and initiate Transaction
my $transactionresult1 = $storeobject->ProcessTransaction({
	CARROT => 2,
	HIDEANDSEEK => 3,
	POMO => 1,
});
print "$transactionresult1\n";

my $transactionresult2 = $storeobject->ProcessTransaction({
	TOMATO => 3,
	CARDOMOM => 1,
});
print "$transactionresult2\n";

#Calculating total sale for the day
my $amt = $storeobject->TotalSales();
print "Closing Balance for the day is $amt\n";

#Check for remaining items in the inventory
my $remainingitems = $storeobject->GetRemainingInventoryItem();
print "Remaining items in the inventory \n";
foreach my $item (keys %$remainingitems) {
	if ($item =~ m/quantity/) {
		print Dumper($remainingitems->{$item});
		print "\n";
	}
}

#Create a cookie object
my $cookieobj = Cookies->new();
#Inherit parent class Items discount and add the cookie class discount
my $discount = $cookieobj->Discount({
        DISCOUNTALLITEM => 10,
})/100;
print "The total items discount and the discount on cookie is $discount\n";
