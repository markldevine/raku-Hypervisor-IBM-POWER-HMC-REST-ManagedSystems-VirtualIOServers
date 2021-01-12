need    Hypervisor::IBM::POWER::HMC::REST::Config;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Analyze;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Dump;
need    Hypervisor::IBM::POWER::HMC::REST::Config::Optimize;
use     Hypervisor::IBM::POWER::HMC::REST::Config::Traits;
need    Hypervisor::IBM::POWER::HMC::REST::ETL::XML;
unit    class Hypervisor::IBM::POWER::HMC::REST::ManagedSystems::ManagedSystem::VirtualIOServers::VirtualIOServer::PartitionCapabilities:api<1>:auth<Mark Devine (mark@markdevine.com)>
            does Hypervisor::IBM::POWER::HMC::REST::Config::Analyze
            does Hypervisor::IBM::POWER::HMC::REST::Config::Dump
            does Hypervisor::IBM::POWER::HMC::REST::Config::Optimize
            does Hypervisor::IBM::POWER::HMC::REST::ETL::XML;

my      Bool                                        $names-checked  = False;
my      Bool                                        $analyzed       = False;
my      Lock                                        $lock           = Lock.new;
has     Hypervisor::IBM::POWER::HMC::REST::Config   $.config        is required;
has     Bool                                        $.initialized   = False;
has     Str                                         $.DynamicLogicalPartitionIOCapable                          is conditional-initialization-attribute;
has     Str                                         $.DynamicLogicalPartitionMemoryCapable                      is conditional-initialization-attribute;
has     Str                                         $.DynamicLogicalPartitionVIOSCapable                        is conditional-initialization-attribute;
has     Str                                         $.DynamicLogicalPartitionProcessorCapable                   is conditional-initialization-attribute;
has     Str                                         $.InternalAndExternalIntrusionDetectionCapable              is conditional-initialization-attribute;
has     Str                                         $.ResourceMonitoringControlOperatingSystemShutdownCapable   is conditional-initialization-attribute;

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
    return self                                                 if $!initialized;
    self.config.diag.post:                                      self.^name ~ '::' ~ &?ROUTINE.name if %*ENV<HIPH_METHOD>;
    $!DynamicLogicalPartitionIOCapable                          = self.etl-text(:TAG<DynamicLogicalPartitionIOCapable>,                         :$!xml) if self.attribute-is-accessed(self.^name, 'DynamicLogicalPartitionIOCapable');
    $!DynamicLogicalPartitionMemoryCapable                      = self.etl-text(:TAG<DynamicLogicalPartitionMemoryCapable>,                     :$!xml) if self.attribute-is-accessed(self.^name, 'DynamicLogicalPartitionMemoryCapable');
    $!DynamicLogicalPartitionVIOSCapable                        = self.etl-text(:TAG<DynamicLogicalPartitionVIOSCapable>,                       :$!xml) if self.attribute-is-accessed(self.^name, 'DynamicLogicalPartitionVIOSCapable');
    $!DynamicLogicalPartitionProcessorCapable                   = self.etl-text(:TAG<DynamicLogicalPartitionProcessorCapable>,                  :$!xml) if self.attribute-is-accessed(self.^name, 'DynamicLogicalPartitionProcessorCapable');
    $!InternalAndExternalIntrusionDetectionCapable              = self.etl-text(:TAG<InternalAndExternalIntrusionDetectionCapable>,             :$!xml) if self.attribute-is-accessed(self.^name, 'InternalAndExternalIntrusionDetectionCapable');
    $!ResourceMonitoringControlOperatingSystemShutdownCapable   = self.etl-text(:TAG<ResourceMonitoringControlOperatingSystemShutdownCapable>,  :$!xml) if self.attribute-is-accessed(self.^name, 'ResourceMonitoringControlOperatingSystemShutdownCapable');
    $!xml                                                       = Nil;
    $!initialized                                               = True;
    self;
}

=finish
