need    Hypervisor::IBM::POWER::HMC::REST::Config;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Analyze;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Dump;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Optimize;
use     Hypervisor::IBM::POWER::HMC::REST::Config::Traits;
need    Hypervisor::IBM::POWER::HMC::REST::ETL::XML;
unit    class Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::SharedEthernetAdapters::SharedEthernetAdapter::TrunkAdapters::TrunkAdapter:api<1>:auth<Mark Devine (mark@markdevine.com)>
            does Hypervisor::IBM::POWER::HMC::REST::Config::Analyze
            does Hypervisor::IBM::POWER::HMC::REST::Config::Dump
            does Hypervisor::IBM::POWER::HMC::REST::Config::Optimize
            does Hypervisor::IBM::POWER::HMC::REST::ETL::XML;

my      Bool                                        $names-checked                          = False;
my      Bool                                        $analyzed                               = False;
my      Lock                                        $lock                                   = Lock.new;
has     Hypervisor::IBM::POWER::HMC::REST::Config   $.config                                is required;
has     Bool                                        $.initialized                           = False;
has     Str                                         $.DynamicReconfigurationConnectorName   is conditional-initialization-attribute;
has     Str                                         $.LocationCode                          is conditional-initialization-attribute;
has     Str                                         $.RequiredAdapter                       is conditional-initialization-attribute;
has     Str                                         $.VariedOn                              is conditional-initialization-attribute;
has     Str                                         $.VirtualSlotNumber                     is conditional-initialization-attribute;
has     Str                                         $.AllowedOperatingSystemMACAddresses    is conditional-initialization-attribute;
has     Str                                         $.MACAddress                            is conditional-initialization-attribute;
has     Str                                         $.PortVLANID                            is conditional-initialization-attribute;
has     Str                                         $.QualityOfServicePriorityEnabled       is conditional-initialization-attribute;
has     Str                                         $.TaggedVLANSupported                   is conditional-initialization-attribute;
has     Str                                         $.VirtualSwitchID                       is conditional-initialization-attribute;
has     Str                                         $.DeviceName                            is conditional-initialization-attribute;
has     Str                                         $.TrunkPriority                         is conditional-initialization-attribute;

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
    $!DynamicReconfigurationConnectorName   = self.etl-text(:TAG<DynamicReconfigurationConnectorName>,  :$!xml) if self.attribute-is-accessed(self.^name, 'DynamicReconfigurationConnectorName');
    $!LocationCode                          = self.etl-text(:TAG<LocationCode>,                         :$!xml) if self.attribute-is-accessed(self.^name, 'LocationCode');
    $!RequiredAdapter                       = self.etl-text(:TAG<RequiredAdapter>,                      :$!xml) if self.attribute-is-accessed(self.^name, 'RequiredAdapter');
    $!VariedOn                              = self.etl-text(:TAG<VariedOn>,                             :$!xml) if self.attribute-is-accessed(self.^name, 'VariedOn');
    $!VirtualSlotNumber                     = self.etl-text(:TAG<VirtualSlotNumber>,                    :$!xml) if self.attribute-is-accessed(self.^name, 'VirtualSlotNumber');
    $!AllowedOperatingSystemMACAddresses    = self.etl-text(:TAG<AllowedOperatingSystemMACAddresses>,   :$!xml) if self.attribute-is-accessed(self.^name, 'AllowedOperatingSystemMACAddresses');
    $!MACAddress                            = self.etl-text(:TAG<MACAddress>,                           :$!xml) if self.attribute-is-accessed(self.^name, 'MACAddress');
    $!PortVLANID                            = self.etl-text(:TAG<PortVLANID>,                           :$!xml) if self.attribute-is-accessed(self.^name, 'PortVLANID');
    $!QualityOfServicePriorityEnabled       = self.etl-text(:TAG<QualityOfServicePriorityEnabled>,      :$!xml) if self.attribute-is-accessed(self.^name, 'QualityOfServicePriorityEnabled');
    $!TaggedVLANSupported                   = self.etl-text(:TAG<TaggedVLANSupported>,                  :$!xml) if self.attribute-is-accessed(self.^name, 'TaggedVLANSupported');
    $!VirtualSwitchID                       = self.etl-text(:TAG<VirtualSwitchID>,                      :$!xml) if self.attribute-is-accessed(self.^name, 'VirtualSwitchID');
    $!DeviceName                            = self.etl-text(:TAG<DeviceName>,                           :$!xml) if self.attribute-is-accessed(self.^name, 'DeviceName');
    $!TrunkPriority                         = self.etl-text(:TAG<TrunkPriority>,                        :$!xml) if self.attribute-is-accessed(self.^name, 'TrunkPriority');
    $!xml                                   = Nil;
    $!initialized                           = True;
    self;
}

=finish
