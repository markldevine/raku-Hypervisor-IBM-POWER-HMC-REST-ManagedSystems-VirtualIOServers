need    Hypervisor::IBM::POWER::HMC::REST::Config;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Analyze;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Dump;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Optimize;
use     Hypervisor::IBM::POWER::HMC::REST::Config::Traits;
need    Hypervisor::IBM::POWER::HMC::REST::ETL::XML;
use     URI;
unit    class Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::VirtualNICBackingDevices::VirtualNICBackingDeviceChoice::VirtualNICSRIOVBackingDevice:api<1>:auth<Mark Devine (mark@markdevine.com)>
            does Hypervisor::IBM::POWER::HMC::REST::Config::Analyze
            does Hypervisor::IBM::POWER::HMC::REST::Config::Dump
            does Hypervisor::IBM::POWER::HMC::REST::Config::Optimize
            does Hypervisor::IBM::POWER::HMC::REST::ETL::XML;

my      Bool                                        $names-checked                  = False;
my      Bool                                        $analyzed                       = False;
my      Lock                                        $lock                           = Lock.new;
has     Hypervisor::IBM::POWER::HMC::REST::Config   $.config                        is required;
has     Bool                                        $.initialized                   = False;
has     Str                                         $.DeviceType                    is conditional-initialization-attribute;
has     URI                                         $.AssociatedVirtualIOServer     is conditional-initialization-attribute;
has     URI                                         $.AssociatedVirtualNICDedicated is conditional-initialization-attribute;
has     Str                                         $.IsActive                      is conditional-initialization-attribute;
has     Str                                         $.Status                        is conditional-initialization-attribute;
has     Str                                         $.FailOverPriority              is conditional-initialization-attribute;
has     Str                                         $.RelatedSRIOVAdapterID         is conditional-initialization-attribute;
has     Str                                         $.CurrentCapacityPercentage     is conditional-initialization-attribute;
has     Str                                         $.RelatedSRIOVPhysicalPortID    is conditional-initialization-attribute;
has     URI                                         $.RelatedSRIOVLogicalPort       is conditional-initialization-attribute;
has     Str                                         $.DesiredCapacityPercentage     is conditional-initialization-attribute;
has     Str                                         $.MaxCapacityPercentage         is conditional-initialization-attribute;
has     Str                                         $.DesiredMaxCapacityPercentage  is conditional-initialization-attribute;

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
    return self                     if $!initialized;
    self.config.diag.post:          self.^name ~ '::' ~ &?ROUTINE.name if %*ENV<HIPH_METHOD>;
    $!DeviceType                    = self.etl-text(:TAG<DeviceType>,                                           :$!xml)                 if self.attribute-is-accessed(self.^name, 'DeviceType');
    $!AssociatedVirtualIOServer     = self.etl-href(:xml(self.etl-branch(:TAG<AssociatedVirtualIOServer>,       :$!xml)))               if self.attribute-is-accessed(self.^name, 'AssociatedVirtualIOServer');
    $!AssociatedVirtualNICDedicated = self.etl-href(:xml(self.etl-branch(:TAG<AssociatedVirtualNICDedicated>,   :$!xml, :optional)))    if self.attribute-is-accessed(self.^name, 'AssociatedVirtualNICDedicated');
    $!IsActive                      = self.etl-text(:TAG<IsActive>,                                             :$!xml)                 if self.attribute-is-accessed(self.^name, 'IsActive');
    $!Status                        = self.etl-text(:TAG<Status>,                                               :$!xml)                 if self.attribute-is-accessed(self.^name, 'Status');
    $!FailOverPriority              = self.etl-text(:TAG<FailOverPriority>,                                     :$!xml)                 if self.attribute-is-accessed(self.^name, 'FailOverPriority');
    $!RelatedSRIOVAdapterID         = self.etl-text(:TAG<RelatedSRIOVAdapterID>,                                :$!xml)                 if self.attribute-is-accessed(self.^name, 'RelatedSRIOVAdapterID');
    $!CurrentCapacityPercentage     = self.etl-text(:TAG<CurrentCapacityPercentage>,                            :$!xml)                 if self.attribute-is-accessed(self.^name, 'CurrentCapacityPercentage');
    $!RelatedSRIOVPhysicalPortID    = self.etl-text(:TAG<RelatedSRIOVPhysicalPortID>,                           :$!xml)                 if self.attribute-is-accessed(self.^name, 'RelatedSRIOVPhysicalPortID');
    $!RelatedSRIOVLogicalPort       = self.etl-href(:xml(self.etl-branch(:TAG<RelatedSRIOVLogicalPort>,         :$!xml)))               if self.attribute-is-accessed(self.^name, 'RelatedSRIOVLogicalPort');
    $!DesiredCapacityPercentage     = self.etl-text(:TAG<DesiredCapacityPercentage>,                            :$!xml)                 if self.attribute-is-accessed(self.^name, 'DesiredCapacityPercentage');
    $!MaxCapacityPercentage         = self.etl-text(:TAG<MaxCapacityPercentage>,                                :$!xml)                 if self.attribute-is-accessed(self.^name, 'MaxCapacityPercentage');
    $!DesiredMaxCapacityPercentage  = self.etl-text(:TAG<DesiredMaxCapacityPercentage>,                         :$!xml)                 if self.attribute-is-accessed(self.^name, 'DesiredMaxCapacityPercentage');
    $!xml                           = Nil;
    $!initialized                   = True;
    self;
}

=finish
