need    Hypervisor::IBM::POWER::HMC::REST::Config;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Analyze;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Dump;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Optimize;
use     Hypervisor::IBM::POWER::HMC::REST::Config::Traits;
need    Hypervisor::IBM::POWER::HMC::REST::ETL::XML;
use     URI;
unit    class Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::VirtualFibreChannelMappings::VirtualFibreChannelMapping::ClientAdapter:api<1>:auth<Mark Devine (mark@markdevine.com)>
            does Hypervisor::IBM::POWER::HMC::REST::Config::Analyze
            does Hypervisor::IBM::POWER::HMC::REST::Config::Dump
            does Hypervisor::IBM::POWER::HMC::REST::Config::Optimize
            does Hypervisor::IBM::POWER::HMC::REST::ETL::XML;

my      Bool                                        $names-checked                          = False;
my      Bool                                        $analyzed                               = False;
my      Lock                                        $lock                                   = Lock.new;
has     Hypervisor::IBM::POWER::HMC::REST::Config   $.config                                is required;
has     Bool                                        $.initialized                           = False;
has     Bool                                        $.loaded                                = False;
has     Str                                         $.AdapterType                           is conditional-initialization-attribute;
has     Str                                         $.DynamicReconfigurationConnectorName   is conditional-initialization-attribute;
has     Str                                         $.LocationCode                          is conditional-initialization-attribute;
has     Str                                         $.LocalPartitionID                      is conditional-initialization-attribute;
has     Str                                         $.RequiredAdapter                       is conditional-initialization-attribute;
has     Str                                         $.VariedOn                              is conditional-initialization-attribute;
has     Str                                         $.VirtualSlotNumber                     is conditional-initialization-attribute;
has     Str                                         $.ConnectingPartitionID                 is conditional-initialization-attribute;
has     Str                                         $.ConnectingVirtualSlotNumber           is conditional-initialization-attribute;
has     Str                                         $.WWPNs                                 is conditional-initialization-attribute;

method  xml-name-exceptions () { return set <Metadata>; }

submethod TWEAK {
    self.config.diag.post:      self.^name ~ '::' ~ &?ROUTINE.name if %*ENV<HIPH_SUBMETHOD>;
    my $proceed-with-name-check = False;
    my $proceed-with-analyze    = False;
    $lock.protect({
        if !$analyzed           { $proceed-with-analyze    = True; $analyzed      = True; }
        if !$names-checked      { $proceed-with-name-check = True; $names-checked = True; }
    });
    self.etl-node-name-check    if $proceed-with-name-check;
    self.init;
    self.analyze                if $proceed-with-analyze;
    self;
}

method init () {
    return self                             if $!initialized;
    self.config.diag.post:                  self.^name ~ '::' ~ &?ROUTINE.name if %*ENV<HIPH_METHOD>;
    $!AdapterType                           = self.etl-text(:TAG<AdapterType>,                          :$!xml, :optional)  if self.attribute-is-accessed(self.^name, 'AdapterType');
    $!DynamicReconfigurationConnectorName   = self.etl-text(:TAG<DynamicReconfigurationConnectorName>,  :$!xml, :optional)  if self.attribute-is-accessed(self.^name, 'DynamicReconfigurationConnectorName');
    $!LocationCode                          = self.etl-text(:TAG<LocationCode>,                         :$!xml, :optional)  if self.attribute-is-accessed(self.^name, 'LocationCode');
    $!LocalPartitionID                      = self.etl-text(:TAG<LocalPartitionID>,                     :$!xml, :optional)  if self.attribute-is-accessed(self.^name, 'LocalPartitionID');
    $!RequiredAdapter                       = self.etl-text(:TAG<RequiredAdapter>,                      :$!xml, :optional)  if self.attribute-is-accessed(self.^name, 'RequiredAdapter');
    $!VariedOn                              = self.etl-text(:TAG<VariedOn>,                             :$!xml, :optional)  if self.attribute-is-accessed(self.^name, 'VariedOn');
    $!VirtualSlotNumber                     = self.etl-text(:TAG<VirtualSlotNumber>,                    :$!xml, :optional)  if self.attribute-is-accessed(self.^name, 'VirtualSlotNumber');
    $!ConnectingPartitionID                 = self.etl-text(:TAG<ConnectingPartitionID>,                :$!xml, :optional)  if self.attribute-is-accessed(self.^name, 'ConnectingPartitionID');
    $!ConnectingVirtualSlotNumber           = self.etl-text(:TAG<ConnectingVirtualSlotNumber>,          :$!xml, :optional)  if self.attribute-is-accessed(self.^name, 'ConnectingVirtualSlotNumber');
    $!WWPNs                                 = self.etl-text(:TAG<WWPNs>,                                :$!xml, :optional)  if self.attribute-is-accessed(self.^name, 'WWPNs');
    $!xml                                   = Nil;
    $!initialized                           = True;
    self;
}

=finish
