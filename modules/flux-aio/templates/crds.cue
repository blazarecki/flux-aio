package templates

customresourcedefinition: "alerts.notification.toolkit.fluxcd.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.12.0"
		name: "alerts.notification.toolkit.fluxcd.io"
	}
	spec: {
		group: "notification.toolkit.fluxcd.io"
		names: {
			kind:     "Alert"
			listKind: "AlertList"
			plural:   "alerts"
			singular: "alert"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
				name:     "Ready"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
				name:     "Status"
				type:     "string"
			}]
			deprecated:         true
			deprecationWarning: "v1beta1 Alert is deprecated, upgrade to v1beta3"
			name:               "v1beta1"
			schema: openAPIV3Schema: {
				description: "Alert is the Schema for the alerts API"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "AlertSpec defines an alerting rule for events involving a list of objects"

						properties: {
							eventSeverity: {
								default:     "info"
								description: "Filter events based on severity, defaults to ('info'). If set to 'info' no events will be filtered."

								enum: [
									"info",
									"error",
								]
								type: "string"
							}
							eventSources: {
								description: "Filter events based on the involved objects."
								items: {
									description: "CrossNamespaceObjectReference contains enough information to let you locate the typed referenced object at cluster level"

									properties: {
										apiVersion: {
											description: "API version of the referent"
											type:        "string"
										}
										kind: {
											description: "Kind of the referent"
											enum: [
												"Bucket",
												"GitRepository",
												"Kustomization",
												"HelmRelease",
												"HelmChart",
												"HelmRepository",
												"ImageRepository",
												"ImagePolicy",
												"ImageUpdateAutomation",
												"OCIRepository",
											]
											type: "string"
										}
										matchLabels: {
											additionalProperties: type: "string"
											description: "MatchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."

											type: "object"
										}
										name: {
											description: "Name of the referent"
											maxLength:   53
											minLength:   1
											type:        "string"
										}
										namespace: {
											description: "Namespace of the referent"
											maxLength:   53
											minLength:   1
											type:        "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								type: "array"
							}
							exclusionList: {
								description: "A list of Golang regular expressions to be used for excluding messages."

								items: type: "string"
								type: "array"
							}
							providerRef: {
								description: "Send events using this provider."
								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							summary: {
								description: "Short description of the impact and affected cluster."
								type:        "string"
							}
							suspend: {
								description: "This flag tells the controller to suspend subsequent events dispatching. Defaults to false."

								type: "boolean"
							}
						}
						required: [
							"eventSources",
							"providerRef",
						]
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "AlertStatus defines the observed state of Alert"
						properties: {
							conditions: {
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last observed generation."
								format:      "int64"
								type:        "integer"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: false
			subresources: status: {}
		}, {
			additionalPrinterColumns: [{
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
				name:     "Ready"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
				name:     "Status"
				type:     "string"
			}]
			deprecated:         true
			deprecationWarning: "v1beta2 Alert is deprecated, upgrade to v1beta3"
			name:               "v1beta2"
			schema: openAPIV3Schema: {
				description: "Alert is the Schema for the alerts API"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "AlertSpec defines an alerting rule for events involving a list of objects."

						properties: {
							eventMetadata: {
								additionalProperties: type: "string"
								description: "EventMetadata is an optional field for adding metadata to events dispatched by the controller. This can be used for enhancing the context of the event. If a field would override one already present on the original event as generated by the emitter, then the override doesn't happen, i.e. the original value is preserved, and an info log is printed."

								type: "object"
							}
							eventSeverity: {
								default:     "info"
								description: "EventSeverity specifies how to filter events based on severity. If set to 'info' no events will be filtered."

								enum: [
									"info",
									"error",
								]
								type: "string"
							}
							eventSources: {
								description: "EventSources specifies how to filter events based on the involved object kind, name and namespace."

								items: {
									description: "CrossNamespaceObjectReference contains enough information to let you locate the typed referenced object at cluster level"

									properties: {
										apiVersion: {
											description: "API version of the referent"
											type:        "string"
										}
										kind: {
											description: "Kind of the referent"
											enum: [
												"Bucket",
												"GitRepository",
												"Kustomization",
												"HelmRelease",
												"HelmChart",
												"HelmRepository",
												"ImageRepository",
												"ImagePolicy",
												"ImageUpdateAutomation",
												"OCIRepository",
											]
											type: "string"
										}
										matchLabels: {
											additionalProperties: type: "string"
											description: "MatchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed. MatchLabels requires the name to be set to `*`."

											type: "object"
										}
										name: {
											description: "Name of the referent If multiple resources are targeted `*` may be set."

											maxLength: 53
											minLength: 1
											type:      "string"
										}
										namespace: {
											description: "Namespace of the referent"
											maxLength:   53
											minLength:   1
											type:        "string"
										}
									}
									required: [
										"kind",
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							exclusionList: {
								description: "ExclusionList specifies a list of Golang regular expressions to be used for excluding messages."

								items: type: "string"
								type: "array"
							}
							inclusionList: {
								description: "InclusionList specifies a list of Golang regular expressions to be used for including messages."

								items: type: "string"
								type: "array"
							}
							providerRef: {
								description: "ProviderRef specifies which Provider this Alert should use."

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							summary: {
								description: "Summary holds a short description of the impact and affected cluster."

								maxLength: 255
								type:      "string"
							}
							suspend: {
								description: "Suspend tells the controller to suspend subsequent events handling for this Alert."

								type: "boolean"
							}
						}
						required: [
							"eventSources",
							"providerRef",
						]
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "AlertStatus defines the observed state of the Alert."
						properties: {
							conditions: {
								description: "Conditions holds the conditions for the Alert."
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							lastHandledReconcileAt: {
								description: "LastHandledReconcileAt holds the value of the most recent reconcile request value, so a change of the annotation value can be detected."

								type: "string"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last observed generation."
								format:      "int64"
								type:        "integer"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: false
			subresources: status: {}
		}, {
			additionalPrinterColumns: [{
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1beta3"
			schema: openAPIV3Schema: {
				description: "Alert is the Schema for the alerts API"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "AlertSpec defines an alerting rule for events involving a list of objects."

						properties: {
							eventMetadata: {
								additionalProperties: type: "string"
								description: "EventMetadata is an optional field for adding metadata to events dispatched by the controller. This can be used for enhancing the context of the event. If a field would override one already present on the original event as generated by the emitter, then the override doesn't happen, i.e. the original value is preserved, and an info log is printed."

								type: "object"
							}
							eventSeverity: {
								default:     "info"
								description: "EventSeverity specifies how to filter events based on severity. If set to 'info' no events will be filtered."

								enum: [
									"info",
									"error",
								]
								type: "string"
							}
							eventSources: {
								description: "EventSources specifies how to filter events based on the involved object kind, name and namespace."

								items: {
									description: "CrossNamespaceObjectReference contains enough information to let you locate the typed referenced object at cluster level"

									properties: {
										apiVersion: {
											description: "API version of the referent"
											type:        "string"
										}
										kind: {
											description: "Kind of the referent"
											enum: [
												"Bucket",
												"GitRepository",
												"Kustomization",
												"HelmRelease",
												"HelmChart",
												"HelmRepository",
												"ImageRepository",
												"ImagePolicy",
												"ImageUpdateAutomation",
												"OCIRepository",
											]
											type: "string"
										}
										matchLabels: {
											additionalProperties: type: "string"
											description: "MatchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed. MatchLabels requires the name to be set to `*`."

											type: "object"
										}
										name: {
											description: "Name of the referent If multiple resources are targeted `*` may be set."

											maxLength: 53
											minLength: 1
											type:      "string"
										}
										namespace: {
											description: "Namespace of the referent"
											maxLength:   53
											minLength:   1
											type:        "string"
										}
									}
									required: [
										"kind",
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							exclusionList: {
								description: "ExclusionList specifies a list of Golang regular expressions to be used for excluding messages."

								items: type: "string"
								type: "array"
							}
							inclusionList: {
								description: "InclusionList specifies a list of Golang regular expressions to be used for including messages."

								items: type: "string"
								type: "array"
							}
							providerRef: {
								description: "ProviderRef specifies which Provider this Alert should use."

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							summary: {
								description: "Summary holds a short description of the impact and affected cluster."

								maxLength: 255
								type:      "string"
							}
							suspend: {
								description: "Suspend tells the controller to suspend subsequent events handling for this Alert."

								type: "boolean"
							}
						}
						required: [
							"eventSources",
							"providerRef",
						]
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: true
			subresources: {}
		}]
	}
}
customresourcedefinition: "buckets.source.toolkit.fluxcd.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.12.0"
		name: "buckets.source.toolkit.fluxcd.io"
	}
	spec: {
		group: "source.toolkit.fluxcd.io"
		names: {
			kind:     "Bucket"
			listKind: "BucketList"
			plural:   "buckets"
			singular: "bucket"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".spec.endpoint"
				name:     "Endpoint"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
				name:     "Ready"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
				name:     "Status"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "Bucket is the Schema for the buckets API"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "BucketSpec defines the desired state of an S3 compatible bucket"

						properties: {
							accessFrom: {
								description: "AccessFrom defines an Access Control List for allowing cross-namespace references to this object."

								properties: namespaceSelectors: {
									description: "NamespaceSelectors is the list of namespace selectors to which this ACL applies. Items in this list are evaluated using a logical OR operation."

									items: {
										description: "NamespaceSelector selects the namespaces to which this ACL applies. An empty map of MatchLabels matches all namespaces in a cluster."

										properties: matchLabels: {
											additionalProperties: type: "string"
											description: "MatchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."

											type: "object"
										}
										type: "object"
									}
									type: "array"
								}
								required: ["namespaceSelectors"]
								type: "object"
							}
							bucketName: {
								description: "The bucket name."
								type:        "string"
							}
							endpoint: {
								description: "The bucket endpoint address."
								type:        "string"
							}
							ignore: {
								description: "Ignore overrides the set of excluded patterns in the .sourceignore format (which is the same as .gitignore). If not provided, a default will be used, consult the documentation for your version to find out what those are."

								type: "string"
							}
							insecure: {
								description: "Insecure allows connecting to a non-TLS S3 HTTP endpoint."
								type:        "boolean"
							}
							interval: {
								description: "The interval at which to check for bucket updates."
								type:        "string"
							}
							provider: {
								default:     "generic"
								description: "The S3 compatible storage provider name, default ('generic')."
								enum: [
									"generic",
									"aws",
									"gcp",
								]
								type: "string"
							}
							region: {
								description: "The bucket region."
								type:        "string"
							}
							secretRef: {
								description: "The name of the secret containing authentication credentials for the Bucket."

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							suspend: {
								description: "This flag tells the controller to suspend the reconciliation of this source."

								type: "boolean"
							}
							timeout: {
								default:     "60s"
								description: "The timeout for download operations, defaults to 60s."
								type:        "string"
							}
						}
						required: [
							"bucketName",
							"endpoint",
							"interval",
						]
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "BucketStatus defines the observed state of a bucket"
						properties: {
							artifact: {
								description: "Artifact represents the output of the last successful Bucket sync."

								properties: {
									checksum: {
										description: "Checksum is the SHA256 checksum of the artifact."
										type:        "string"
									}
									lastUpdateTime: {
										description: "LastUpdateTime is the timestamp corresponding to the last update of this artifact."

										format: "date-time"
										type:   "string"
									}
									path: {
										description: "Path is the relative file path of this artifact."
										type:        "string"
									}
									revision: {
										description: "Revision is a human readable identifier traceable in the origin source system. It can be a Git commit SHA, Git tag, a Helm index timestamp, a Helm chart version, etc."

										type: "string"
									}
									url: {
										description: "URL is the HTTP address of this artifact."
										type:        "string"
									}
								}
								required: [
									"path",
									"url",
								]
								type: "object"
							}
							conditions: {
								description: "Conditions holds the conditions for the Bucket."
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							lastHandledReconcileAt: {
								description: "LastHandledReconcileAt holds the value of the most recent reconcile request value, so a change of the annotation value can be detected."

								type: "string"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last observed generation."
								format:      "int64"
								type:        "integer"
							}
							url: {
								description: "URL is the download link for the artifact output of the last Bucket sync."

								type: "string"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: false
			subresources: status: {}
		}, {
			additionalPrinterColumns: [{
				jsonPath: ".spec.endpoint"
				name:     "Endpoint"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
				name:     "Ready"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
				name:     "Status"
				type:     "string"
			}]
			name: "v1beta2"
			schema: openAPIV3Schema: {
				description: "Bucket is the Schema for the buckets API."
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "BucketSpec specifies the required configuration to produce an Artifact for an object storage bucket."

						properties: {
							accessFrom: {
								description: "AccessFrom specifies an Access Control List for allowing cross-namespace references to this object. NOTE: Not implemented, provisional as of https://github.com/fluxcd/flux2/pull/2092"

								properties: namespaceSelectors: {
									description: "NamespaceSelectors is the list of namespace selectors to which this ACL applies. Items in this list are evaluated using a logical OR operation."

									items: {
										description: "NamespaceSelector selects the namespaces to which this ACL applies. An empty map of MatchLabels matches all namespaces in a cluster."

										properties: matchLabels: {
											additionalProperties: type: "string"
											description: "MatchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."

											type: "object"
										}
										type: "object"
									}
									type: "array"
								}
								required: ["namespaceSelectors"]
								type: "object"
							}
							bucketName: {
								description: "BucketName is the name of the object storage bucket."
								type:        "string"
							}
							endpoint: {
								description: "Endpoint is the object storage address the BucketName is located at."

								type: "string"
							}
							ignore: {
								description: "Ignore overrides the set of excluded patterns in the .sourceignore format (which is the same as .gitignore). If not provided, a default will be used, consult the documentation for your version to find out what those are."

								type: "string"
							}
							insecure: {
								description: "Insecure allows connecting to a non-TLS HTTP Endpoint."
								type:        "boolean"
							}
							interval: {
								description: "Interval at which the Bucket Endpoint is checked for updates. This interval is approximate and may be subject to jitter to ensure efficient use of resources."

								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
								type:    "string"
							}
							prefix: {
								description: "Prefix to use for server-side filtering of files in the Bucket."

								type: "string"
							}
							provider: {
								default:     "generic"
								description: "Provider of the object storage bucket. Defaults to 'generic', which expects an S3 (API) compatible object storage."

								enum: [
									"generic",
									"aws",
									"gcp",
									"azure",
								]
								type: "string"
							}
							region: {
								description: "Region of the Endpoint where the BucketName is located in."

								type: "string"
							}
							secretRef: {
								description: "SecretRef specifies the Secret containing authentication credentials for the Bucket."

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							suspend: {
								description: "Suspend tells the controller to suspend the reconciliation of this Bucket."

								type: "boolean"
							}
							timeout: {
								default:     "60s"
								description: "Timeout for fetch operations, defaults to 60s."
								pattern:     "^([0-9]+(\\.[0-9]+)?(ms|s|m))+$"
								type:        "string"
							}
						}
						required: [
							"bucketName",
							"endpoint",
							"interval",
						]
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "BucketStatus records the observed state of a Bucket."
						properties: {
							artifact: {
								description: "Artifact represents the last successful Bucket reconciliation."
								properties: {
									digest: {
										description: "Digest is the digest of the file in the form of '<algorithm>:<checksum>'."
										pattern:     "^[a-z0-9]+(?:[.+_-][a-z0-9]+)*:[a-zA-Z0-9=_-]+$"
										type:        "string"
									}
									lastUpdateTime: {
										description: "LastUpdateTime is the timestamp corresponding to the last update of the Artifact."

										format: "date-time"
										type:   "string"
									}
									metadata: {
										additionalProperties: type: "string"
										description: "Metadata holds upstream information such as OCI annotations."
										type:        "object"
									}
									path: {
										description: "Path is the relative file path of the Artifact. It can be used to locate the file in the root of the Artifact storage on the local file system of the controller managing the Source."

										type: "string"
									}
									revision: {
										description: "Revision is a human-readable identifier traceable in the origin source system. It can be a Git commit SHA, Git tag, a Helm chart version, etc."

										type: "string"
									}
									size: {
										description: "Size is the number of bytes in the file."
										format:      "int64"
										type:        "integer"
									}
									url: {
										description: "URL is the HTTP address of the Artifact as exposed by the controller managing the Source. It can be used to retrieve the Artifact for consumption, e.g. by another controller applying the Artifact contents."

										type: "string"
									}
								}
								required: [
									"lastUpdateTime",
									"path",
									"revision",
									"url",
								]
								type: "object"
							}
							conditions: {
								description: "Conditions holds the conditions for the Bucket."
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							lastHandledReconcileAt: {
								description: "LastHandledReconcileAt holds the value of the most recent reconcile request value, so a change of the annotation value can be detected."

								type: "string"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last observed generation of the Bucket object."

								format: "int64"
								type:   "integer"
							}
							observedIgnore: {
								description: "ObservedIgnore is the observed exclusion patterns used for constructing the source artifact."

								type: "string"
							}
							url: {
								description: "URL is the dynamic fetch link for the latest Artifact. It is provided on a \"best effort\" basis, and using the precise BucketStatus.Artifact data is recommended."

								type: "string"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}
customresourcedefinition: "gitrepositories.source.toolkit.fluxcd.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.12.0"
		name: "gitrepositories.source.toolkit.fluxcd.io"
	}
	spec: {
		group: "source.toolkit.fluxcd.io"
		names: {
			kind:     "GitRepository"
			listKind: "GitRepositoryList"
			plural:   "gitrepositories"
			shortNames: ["gitrepo"]
			singular: "gitrepository"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".spec.url"
				name:     "URL"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
				name:     "Ready"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
				name:     "Status"
				type:     "string"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				description: "GitRepository is the Schema for the gitrepositories API."
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "GitRepositorySpec specifies the required configuration to produce an Artifact for a Git repository."

						properties: {
							ignore: {
								description: "Ignore overrides the set of excluded patterns in the .sourceignore format (which is the same as .gitignore). If not provided, a default will be used, consult the documentation for your version to find out what those are."

								type: "string"
							}
							include: {
								description: "Include specifies a list of GitRepository resources which Artifacts should be included in the Artifact produced for this GitRepository."

								items: {
									description: "GitRepositoryInclude specifies a local reference to a GitRepository which Artifact (sub-)contents must be included, and where they should be placed."

									properties: {
										fromPath: {
											description: "FromPath specifies the path to copy contents from, defaults to the root of the Artifact."

											type: "string"
										}
										repository: {
											description: "GitRepositoryRef specifies the GitRepository which Artifact contents must be included."

											properties: name: {
												description: "Name of the referent."
												type:        "string"
											}
											required: ["name"]
											type: "object"
										}
										toPath: {
											description: "ToPath specifies the path to copy contents to, defaults to the name of the GitRepositoryRef."

											type: "string"
										}
									}
									required: ["repository"]
									type: "object"
								}
								type: "array"
							}
							interval: {
								description: "Interval at which the GitRepository URL is checked for updates. This interval is approximate and may be subject to jitter to ensure efficient use of resources."

								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
								type:    "string"
							}
							proxySecretRef: {
								description: "ProxySecretRef specifies the Secret containing the proxy configuration to use while communicating with the Git server."

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							recurseSubmodules: {
								description: "RecurseSubmodules enables the initialization of all submodules within the GitRepository as cloned from the URL, using their default settings."

								type: "boolean"
							}
							ref: {
								description: "Reference specifies the Git reference to resolve and monitor for changes, defaults to the 'master' branch."

								properties: {
									branch: {
										description: "Branch to check out, defaults to 'master' if no other field is defined."

										type: "string"
									}
									commit: {
										description: """
		Commit SHA to check out, takes precedence over all reference fields. 
		 This can be combined with Branch to shallow clone the branch, in which the commit is expected to exist.
		"""

										type: "string"
									}
									name: {
										description: """
		Name of the reference to check out; takes precedence over Branch, Tag and SemVer. 
		 It must be a valid Git reference: https://git-scm.com/docs/git-check-ref-format#_description Examples: \"refs/heads/main\", \"refs/tags/v0.1.0\", \"refs/pull/420/head\", \"refs/merge-requests/1/head\"
		"""

										type: "string"
									}
									semver: {
										description: "SemVer tag expression to check out, takes precedence over Tag."

										type: "string"
									}
									tag: {
										description: "Tag to check out, takes precedence over Branch."
										type:        "string"
									}
								}
								type: "object"
							}
							secretRef: {
								description: "SecretRef specifies the Secret containing authentication credentials for the GitRepository. For HTTPS repositories the Secret must contain 'username' and 'password' fields for basic auth or 'bearerToken' field for token auth. For SSH repositories the Secret must contain 'identity' and 'known_hosts' fields."

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							suspend: {
								description: "Suspend tells the controller to suspend the reconciliation of this GitRepository."

								type: "boolean"
							}
							timeout: {
								default:     "60s"
								description: "Timeout for Git operations like cloning, defaults to 60s."

								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m))+$"
								type:    "string"
							}
							url: {
								description: "URL specifies the Git repository URL, it can be an HTTP/S or SSH address."

								pattern: "^(http|https|ssh)://.*$"
								type:    "string"
							}
							verify: {
								description: "Verification specifies the configuration to verify the Git commit signature(s)."

								properties: {
									mode: {
										default: "HEAD"
										description: """
		Mode specifies which Git object(s) should be verified. 
		 The variants \"head\" and \"HEAD\" both imply the same thing, i.e. verify the commit that the HEAD of the Git repository points to. The variant \"head\" solely exists to ensure backwards compatibility.
		"""

										enum: [
											"head",
											"HEAD",
											"Tag",
											"TagAndHEAD",
										]
										type: "string"
									}
									secretRef: {
										description: "SecretRef specifies the Secret containing the public keys of trusted Git authors."

										properties: name: {
											description: "Name of the referent."
											type:        "string"
										}
										required: ["name"]
										type: "object"
									}
								}
								required: ["secretRef"]
								type: "object"
							}
						}
						required: [
							"interval",
							"url",
						]
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "GitRepositoryStatus records the observed state of a Git repository."
						properties: {
							artifact: {
								description: "Artifact represents the last successful GitRepository reconciliation."

								properties: {
									digest: {
										description: "Digest is the digest of the file in the form of '<algorithm>:<checksum>'."
										pattern:     "^[a-z0-9]+(?:[.+_-][a-z0-9]+)*:[a-zA-Z0-9=_-]+$"
										type:        "string"
									}
									lastUpdateTime: {
										description: "LastUpdateTime is the timestamp corresponding to the last update of the Artifact."

										format: "date-time"
										type:   "string"
									}
									metadata: {
										additionalProperties: type: "string"
										description: "Metadata holds upstream information such as OCI annotations."
										type:        "object"
									}
									path: {
										description: "Path is the relative file path of the Artifact. It can be used to locate the file in the root of the Artifact storage on the local file system of the controller managing the Source."

										type: "string"
									}
									revision: {
										description: "Revision is a human-readable identifier traceable in the origin source system. It can be a Git commit SHA, Git tag, a Helm chart version, etc."

										type: "string"
									}
									size: {
										description: "Size is the number of bytes in the file."
										format:      "int64"
										type:        "integer"
									}
									url: {
										description: "URL is the HTTP address of the Artifact as exposed by the controller managing the Source. It can be used to retrieve the Artifact for consumption, e.g. by another controller applying the Artifact contents."

										type: "string"
									}
								}
								required: [
									"lastUpdateTime",
									"path",
									"revision",
									"url",
								]
								type: "object"
							}
							conditions: {
								description: "Conditions holds the conditions for the GitRepository."
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							includedArtifacts: {
								description: "IncludedArtifacts contains a list of the last successfully included Artifacts as instructed by GitRepositorySpec.Include."

								items: {
									description: "Artifact represents the output of a Source reconciliation."
									properties: {
										digest: {
											description: "Digest is the digest of the file in the form of '<algorithm>:<checksum>'."

											pattern: "^[a-z0-9]+(?:[.+_-][a-z0-9]+)*:[a-zA-Z0-9=_-]+$"
											type:    "string"
										}
										lastUpdateTime: {
											description: "LastUpdateTime is the timestamp corresponding to the last update of the Artifact."

											format: "date-time"
											type:   "string"
										}
										metadata: {
											additionalProperties: type: "string"
											description: "Metadata holds upstream information such as OCI annotations."

											type: "object"
										}
										path: {
											description: "Path is the relative file path of the Artifact. It can be used to locate the file in the root of the Artifact storage on the local file system of the controller managing the Source."

											type: "string"
										}
										revision: {
											description: "Revision is a human-readable identifier traceable in the origin source system. It can be a Git commit SHA, Git tag, a Helm chart version, etc."

											type: "string"
										}
										size: {
											description: "Size is the number of bytes in the file."
											format:      "int64"
											type:        "integer"
										}
										url: {
											description: "URL is the HTTP address of the Artifact as exposed by the controller managing the Source. It can be used to retrieve the Artifact for consumption, e.g. by another controller applying the Artifact contents."

											type: "string"
										}
									}
									required: [
										"lastUpdateTime",
										"path",
										"revision",
										"url",
									]
									type: "object"
								}
								type: "array"
							}
							lastHandledReconcileAt: {
								description: "LastHandledReconcileAt holds the value of the most recent reconcile request value, so a change of the annotation value can be detected."

								type: "string"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last observed generation of the GitRepository object."

								format: "int64"
								type:   "integer"
							}
							observedIgnore: {
								description: "ObservedIgnore is the observed exclusion patterns used for constructing the source artifact."

								type: "string"
							}
							observedInclude: {
								description: "ObservedInclude is the observed list of GitRepository resources used to produce the current Artifact."

								items: {
									description: "GitRepositoryInclude specifies a local reference to a GitRepository which Artifact (sub-)contents must be included, and where they should be placed."

									properties: {
										fromPath: {
											description: "FromPath specifies the path to copy contents from, defaults to the root of the Artifact."

											type: "string"
										}
										repository: {
											description: "GitRepositoryRef specifies the GitRepository which Artifact contents must be included."

											properties: name: {
												description: "Name of the referent."
												type:        "string"
											}
											required: ["name"]
											type: "object"
										}
										toPath: {
											description: "ToPath specifies the path to copy contents to, defaults to the name of the GitRepositoryRef."

											type: "string"
										}
									}
									required: ["repository"]
									type: "object"
								}
								type: "array"
							}
							observedRecurseSubmodules: {
								description: "ObservedRecurseSubmodules is the observed resource submodules configuration used to produce the current Artifact."

								type: "boolean"
							}
							sourceVerificationMode: {
								description: "SourceVerificationMode is the last used verification mode indicating which Git object(s) have been verified."

								type: "string"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}, {
			additionalPrinterColumns: [{
				jsonPath: ".spec.url"
				name:     "URL"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
				name:     "Ready"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
				name:     "Status"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			deprecated:         true
			deprecationWarning: "v1beta1 GitRepository is deprecated, upgrade to v1"
			name:               "v1beta1"
			schema: openAPIV3Schema: {
				description: "GitRepository is the Schema for the gitrepositories API"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "GitRepositorySpec defines the desired state of a Git repository."
						properties: {
							accessFrom: {
								description: "AccessFrom defines an Access Control List for allowing cross-namespace references to this object."

								properties: namespaceSelectors: {
									description: "NamespaceSelectors is the list of namespace selectors to which this ACL applies. Items in this list are evaluated using a logical OR operation."

									items: {
										description: "NamespaceSelector selects the namespaces to which this ACL applies. An empty map of MatchLabels matches all namespaces in a cluster."

										properties: matchLabels: {
											additionalProperties: type: "string"
											description: "MatchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."

											type: "object"
										}
										type: "object"
									}
									type: "array"
								}
								required: ["namespaceSelectors"]
								type: "object"
							}
							gitImplementation: {
								default:     "go-git"
								description: "Determines which git client library to use. Defaults to go-git, valid values are ('go-git', 'libgit2')."

								enum: [
									"go-git",
									"libgit2",
								]
								type: "string"
							}
							ignore: {
								description: "Ignore overrides the set of excluded patterns in the .sourceignore format (which is the same as .gitignore). If not provided, a default will be used, consult the documentation for your version to find out what those are."

								type: "string"
							}
							include: {
								description: "Extra git repositories to map into the repository"
								items: {
									description: "GitRepositoryInclude defines a source with a from and to path."

									properties: {
										fromPath: {
											description: "The path to copy contents from, defaults to the root directory."

											type: "string"
										}
										repository: {
											description: "Reference to a GitRepository to include."
											properties: name: {
												description: "Name of the referent."
												type:        "string"
											}
											required: ["name"]
											type: "object"
										}
										toPath: {
											description: "The path to copy contents to, defaults to the name of the source ref."

											type: "string"
										}
									}
									required: ["repository"]
									type: "object"
								}
								type: "array"
							}
							interval: {
								description: "The interval at which to check for repository updates."
								type:        "string"
							}
							recurseSubmodules: {
								description: "When enabled, after the clone is created, initializes all submodules within, using their default settings. This option is available only when using the 'go-git' GitImplementation."

								type: "boolean"
							}
							ref: {
								description: "The Git reference to checkout and monitor for changes, defaults to master branch."

								properties: {
									branch: {
										description: "The Git branch to checkout, defaults to master."
										type:        "string"
									}
									commit: {
										description: "The Git commit SHA to checkout, if specified Tag filters will be ignored."

										type: "string"
									}
									semver: {
										description: "The Git tag semver expression, takes precedence over Tag."

										type: "string"
									}
									tag: {
										description: "The Git tag to checkout, takes precedence over Branch."
										type:        "string"
									}
								}
								type: "object"
							}
							secretRef: {
								description: "The secret name containing the Git credentials. For HTTPS repositories the secret must contain username and password fields. For SSH repositories the secret must contain identity and known_hosts fields."

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							suspend: {
								description: "This flag tells the controller to suspend the reconciliation of this source."

								type: "boolean"
							}
							timeout: {
								default:     "60s"
								description: "The timeout for remote Git operations like cloning, defaults to 60s."

								type: "string"
							}
							url: {
								description: "The repository URL, can be a HTTP/S or SSH address."
								pattern:     "^(http|https|ssh)://.*$"
								type:        "string"
							}
							verify: {
								description: "Verify OpenPGP signature for the Git commit HEAD points to."

								properties: {
									mode: {
										description: "Mode describes what git object should be verified, currently ('head')."

										enum: ["head"]
										type: "string"
									}
									secretRef: {
										description: "The secret name containing the public keys of all trusted Git authors."

										properties: name: {
											description: "Name of the referent."
											type:        "string"
										}
										required: ["name"]
										type: "object"
									}
								}
								required: ["mode"]
								type: "object"
							}
						}
						required: [
							"interval",
							"url",
						]
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "GitRepositoryStatus defines the observed state of a Git repository."
						properties: {
							artifact: {
								description: "Artifact represents the output of the last successful repository sync."

								properties: {
									checksum: {
										description: "Checksum is the SHA256 checksum of the artifact."
										type:        "string"
									}
									lastUpdateTime: {
										description: "LastUpdateTime is the timestamp corresponding to the last update of this artifact."

										format: "date-time"
										type:   "string"
									}
									path: {
										description: "Path is the relative file path of this artifact."
										type:        "string"
									}
									revision: {
										description: "Revision is a human readable identifier traceable in the origin source system. It can be a Git commit SHA, Git tag, a Helm index timestamp, a Helm chart version, etc."

										type: "string"
									}
									url: {
										description: "URL is the HTTP address of this artifact."
										type:        "string"
									}
								}
								required: [
									"path",
									"url",
								]
								type: "object"
							}
							conditions: {
								description: "Conditions holds the conditions for the GitRepository."
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							includedArtifacts: {
								description: "IncludedArtifacts represents the included artifacts from the last successful repository sync."

								items: {
									description: "Artifact represents the output of a source synchronisation."
									properties: {
										checksum: {
											description: "Checksum is the SHA256 checksum of the artifact."
											type:        "string"
										}
										lastUpdateTime: {
											description: "LastUpdateTime is the timestamp corresponding to the last update of this artifact."

											format: "date-time"
											type:   "string"
										}
										path: {
											description: "Path is the relative file path of this artifact."
											type:        "string"
										}
										revision: {
											description: "Revision is a human readable identifier traceable in the origin source system. It can be a Git commit SHA, Git tag, a Helm index timestamp, a Helm chart version, etc."

											type: "string"
										}
										url: {
											description: "URL is the HTTP address of this artifact."
											type:        "string"
										}
									}
									required: [
										"path",
										"url",
									]
									type: "object"
								}
								type: "array"
							}
							lastHandledReconcileAt: {
								description: "LastHandledReconcileAt holds the value of the most recent reconcile request value, so a change of the annotation value can be detected."

								type: "string"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last observed generation."
								format:      "int64"
								type:        "integer"
							}
							url: {
								description: "URL is the download link for the artifact output of the last repository sync."

								type: "string"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: false
			subresources: status: {}
		}, {
			additionalPrinterColumns: [{
				jsonPath: ".spec.url"
				name:     "URL"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
				name:     "Ready"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
				name:     "Status"
				type:     "string"
			}]
			deprecated:         true
			deprecationWarning: "v1beta2 GitRepository is deprecated, upgrade to v1"
			name:               "v1beta2"
			schema: openAPIV3Schema: {
				description: "GitRepository is the Schema for the gitrepositories API."
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "GitRepositorySpec specifies the required configuration to produce an Artifact for a Git repository."

						properties: {
							accessFrom: {
								description: "AccessFrom specifies an Access Control List for allowing cross-namespace references to this object. NOTE: Not implemented, provisional as of https://github.com/fluxcd/flux2/pull/2092"

								properties: namespaceSelectors: {
									description: "NamespaceSelectors is the list of namespace selectors to which this ACL applies. Items in this list are evaluated using a logical OR operation."

									items: {
										description: "NamespaceSelector selects the namespaces to which this ACL applies. An empty map of MatchLabels matches all namespaces in a cluster."

										properties: matchLabels: {
											additionalProperties: type: "string"
											description: "MatchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."

											type: "object"
										}
										type: "object"
									}
									type: "array"
								}
								required: ["namespaceSelectors"]
								type: "object"
							}
							gitImplementation: {
								default:     "go-git"
								description: "GitImplementation specifies which Git client library implementation to use. Defaults to 'go-git', valid values are ('go-git', 'libgit2'). Deprecated: gitImplementation is deprecated now that 'go-git' is the only supported implementation."

								enum: [
									"go-git",
									"libgit2",
								]
								type: "string"
							}
							ignore: {
								description: "Ignore overrides the set of excluded patterns in the .sourceignore format (which is the same as .gitignore). If not provided, a default will be used, consult the documentation for your version to find out what those are."

								type: "string"
							}
							include: {
								description: "Include specifies a list of GitRepository resources which Artifacts should be included in the Artifact produced for this GitRepository."

								items: {
									description: "GitRepositoryInclude specifies a local reference to a GitRepository which Artifact (sub-)contents must be included, and where they should be placed."

									properties: {
										fromPath: {
											description: "FromPath specifies the path to copy contents from, defaults to the root of the Artifact."

											type: "string"
										}
										repository: {
											description: "GitRepositoryRef specifies the GitRepository which Artifact contents must be included."

											properties: name: {
												description: "Name of the referent."
												type:        "string"
											}
											required: ["name"]
											type: "object"
										}
										toPath: {
											description: "ToPath specifies the path to copy contents to, defaults to the name of the GitRepositoryRef."

											type: "string"
										}
									}
									required: ["repository"]
									type: "object"
								}
								type: "array"
							}
							interval: {
								description: "Interval at which to check the GitRepository for updates."
								pattern:     "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
								type:        "string"
							}
							recurseSubmodules: {
								description: "RecurseSubmodules enables the initialization of all submodules within the GitRepository as cloned from the URL, using their default settings."

								type: "boolean"
							}
							ref: {
								description: "Reference specifies the Git reference to resolve and monitor for changes, defaults to the 'master' branch."

								properties: {
									branch: {
										description: "Branch to check out, defaults to 'master' if no other field is defined."

										type: "string"
									}
									commit: {
										description: """
		Commit SHA to check out, takes precedence over all reference fields. 
		 This can be combined with Branch to shallow clone the branch, in which the commit is expected to exist.
		"""

										type: "string"
									}
									name: {
										description: """
		Name of the reference to check out; takes precedence over Branch, Tag and SemVer. 
		 It must be a valid Git reference: https://git-scm.com/docs/git-check-ref-format#_description Examples: \"refs/heads/main\", \"refs/tags/v0.1.0\", \"refs/pull/420/head\", \"refs/merge-requests/1/head\"
		"""

										type: "string"
									}
									semver: {
										description: "SemVer tag expression to check out, takes precedence over Tag."

										type: "string"
									}
									tag: {
										description: "Tag to check out, takes precedence over Branch."
										type:        "string"
									}
								}
								type: "object"
							}
							secretRef: {
								description: "SecretRef specifies the Secret containing authentication credentials for the GitRepository. For HTTPS repositories the Secret must contain 'username' and 'password' fields for basic auth or 'bearerToken' field for token auth. For SSH repositories the Secret must contain 'identity' and 'known_hosts' fields."

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							suspend: {
								description: "Suspend tells the controller to suspend the reconciliation of this GitRepository."

								type: "boolean"
							}
							timeout: {
								default:     "60s"
								description: "Timeout for Git operations like cloning, defaults to 60s."

								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m))+$"
								type:    "string"
							}
							url: {
								description: "URL specifies the Git repository URL, it can be an HTTP/S or SSH address."

								pattern: "^(http|https|ssh)://.*$"
								type:    "string"
							}
							verify: {
								description: "Verification specifies the configuration to verify the Git commit signature(s)."

								properties: {
									mode: {
										description: "Mode specifies what Git object should be verified, currently ('head')."

										enum: ["head"]
										type: "string"
									}
									secretRef: {
										description: "SecretRef specifies the Secret containing the public keys of trusted Git authors."

										properties: name: {
											description: "Name of the referent."
											type:        "string"
										}
										required: ["name"]
										type: "object"
									}
								}
								required: [
									"mode",
									"secretRef",
								]
								type: "object"
							}
						}
						required: [
							"interval",
							"url",
						]
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "GitRepositoryStatus records the observed state of a Git repository."
						properties: {
							artifact: {
								description: "Artifact represents the last successful GitRepository reconciliation."

								properties: {
									digest: {
										description: "Digest is the digest of the file in the form of '<algorithm>:<checksum>'."
										pattern:     "^[a-z0-9]+(?:[.+_-][a-z0-9]+)*:[a-zA-Z0-9=_-]+$"
										type:        "string"
									}
									lastUpdateTime: {
										description: "LastUpdateTime is the timestamp corresponding to the last update of the Artifact."

										format: "date-time"
										type:   "string"
									}
									metadata: {
										additionalProperties: type: "string"
										description: "Metadata holds upstream information such as OCI annotations."
										type:        "object"
									}
									path: {
										description: "Path is the relative file path of the Artifact. It can be used to locate the file in the root of the Artifact storage on the local file system of the controller managing the Source."

										type: "string"
									}
									revision: {
										description: "Revision is a human-readable identifier traceable in the origin source system. It can be a Git commit SHA, Git tag, a Helm chart version, etc."

										type: "string"
									}
									size: {
										description: "Size is the number of bytes in the file."
										format:      "int64"
										type:        "integer"
									}
									url: {
										description: "URL is the HTTP address of the Artifact as exposed by the controller managing the Source. It can be used to retrieve the Artifact for consumption, e.g. by another controller applying the Artifact contents."

										type: "string"
									}
								}
								required: [
									"lastUpdateTime",
									"path",
									"revision",
									"url",
								]
								type: "object"
							}
							conditions: {
								description: "Conditions holds the conditions for the GitRepository."
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							contentConfigChecksum: {
								description: """
		ContentConfigChecksum is a checksum of all the configurations related to the content of the source artifact: - .spec.ignore - .spec.recurseSubmodules - .spec.included and the checksum of the included artifacts observed in .status.observedGeneration version of the object. This can be used to determine if the content of the included repository has changed. It has the format of `<algo>:<checksum>`, for example: `sha256:<checksum>`. 
		 Deprecated: Replaced with explicit fields for observed artifact content config in the status.
		"""

								type: "string"
							}
							includedArtifacts: {
								description: "IncludedArtifacts contains a list of the last successfully included Artifacts as instructed by GitRepositorySpec.Include."

								items: {
									description: "Artifact represents the output of a Source reconciliation."
									properties: {
										digest: {
											description: "Digest is the digest of the file in the form of '<algorithm>:<checksum>'."

											pattern: "^[a-z0-9]+(?:[.+_-][a-z0-9]+)*:[a-zA-Z0-9=_-]+$"
											type:    "string"
										}
										lastUpdateTime: {
											description: "LastUpdateTime is the timestamp corresponding to the last update of the Artifact."

											format: "date-time"
											type:   "string"
										}
										metadata: {
											additionalProperties: type: "string"
											description: "Metadata holds upstream information such as OCI annotations."

											type: "object"
										}
										path: {
											description: "Path is the relative file path of the Artifact. It can be used to locate the file in the root of the Artifact storage on the local file system of the controller managing the Source."

											type: "string"
										}
										revision: {
											description: "Revision is a human-readable identifier traceable in the origin source system. It can be a Git commit SHA, Git tag, a Helm chart version, etc."

											type: "string"
										}
										size: {
											description: "Size is the number of bytes in the file."
											format:      "int64"
											type:        "integer"
										}
										url: {
											description: "URL is the HTTP address of the Artifact as exposed by the controller managing the Source. It can be used to retrieve the Artifact for consumption, e.g. by another controller applying the Artifact contents."

											type: "string"
										}
									}
									required: [
										"lastUpdateTime",
										"path",
										"revision",
										"url",
									]
									type: "object"
								}
								type: "array"
							}
							lastHandledReconcileAt: {
								description: "LastHandledReconcileAt holds the value of the most recent reconcile request value, so a change of the annotation value can be detected."

								type: "string"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last observed generation of the GitRepository object."

								format: "int64"
								type:   "integer"
							}
							observedIgnore: {
								description: "ObservedIgnore is the observed exclusion patterns used for constructing the source artifact."

								type: "string"
							}
							observedInclude: {
								description: "ObservedInclude is the observed list of GitRepository resources used to to produce the current Artifact."

								items: {
									description: "GitRepositoryInclude specifies a local reference to a GitRepository which Artifact (sub-)contents must be included, and where they should be placed."

									properties: {
										fromPath: {
											description: "FromPath specifies the path to copy contents from, defaults to the root of the Artifact."

											type: "string"
										}
										repository: {
											description: "GitRepositoryRef specifies the GitRepository which Artifact contents must be included."

											properties: name: {
												description: "Name of the referent."
												type:        "string"
											}
											required: ["name"]
											type: "object"
										}
										toPath: {
											description: "ToPath specifies the path to copy contents to, defaults to the name of the GitRepositoryRef."

											type: "string"
										}
									}
									required: ["repository"]
									type: "object"
								}
								type: "array"
							}
							observedRecurseSubmodules: {
								description: "ObservedRecurseSubmodules is the observed resource submodules configuration used to produce the current Artifact."

								type: "boolean"
							}
							url: {
								description: "URL is the dynamic fetch link for the latest Artifact. It is provided on a \"best effort\" basis, and using the precise GitRepositoryStatus.Artifact data is recommended."

								type: "string"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: false
			subresources: status: {}
		}]
	}
}
customresourcedefinition: "helmcharts.source.toolkit.fluxcd.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.12.0"
		name: "helmcharts.source.toolkit.fluxcd.io"
	}
	spec: {
		group: "source.toolkit.fluxcd.io"
		names: {
			kind:     "HelmChart"
			listKind: "HelmChartList"
			plural:   "helmcharts"
			shortNames: ["hc"]
			singular: "helmchart"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".spec.chart"
				name:     "Chart"
				type:     "string"
			}, {
				jsonPath: ".spec.version"
				name:     "Version"
				type:     "string"
			}, {
				jsonPath: ".spec.sourceRef.kind"
				name:     "Source Kind"
				type:     "string"
			}, {
				jsonPath: ".spec.sourceRef.name"
				name:     "Source Name"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
				name:     "Ready"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
				name:     "Status"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "HelmChart is the Schema for the helmcharts API"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "HelmChartSpec defines the desired state of a Helm chart."
						properties: {
							accessFrom: {
								description: "AccessFrom defines an Access Control List for allowing cross-namespace references to this object."

								properties: namespaceSelectors: {
									description: "NamespaceSelectors is the list of namespace selectors to which this ACL applies. Items in this list are evaluated using a logical OR operation."

									items: {
										description: "NamespaceSelector selects the namespaces to which this ACL applies. An empty map of MatchLabels matches all namespaces in a cluster."

										properties: matchLabels: {
											additionalProperties: type: "string"
											description: "MatchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."

											type: "object"
										}
										type: "object"
									}
									type: "array"
								}
								required: ["namespaceSelectors"]
								type: "object"
							}
							chart: {
								description: "The name or path the Helm chart is available at in the SourceRef."

								type: "string"
							}
							interval: {
								description: "The interval at which to check the Source for updates."
								type:        "string"
							}
							reconcileStrategy: {
								default:     "ChartVersion"
								description: "Determines what enables the creation of a new artifact. Valid values are ('ChartVersion', 'Revision'). See the documentation of the values for an explanation on their behavior. Defaults to ChartVersion when omitted."

								enum: [
									"ChartVersion",
									"Revision",
								]
								type: "string"
							}
							sourceRef: {
								description: "The reference to the Source the chart is available at."
								properties: {
									apiVersion: {
										description: "APIVersion of the referent."
										type:        "string"
									}
									kind: {
										description: "Kind of the referent, valid values are ('HelmRepository', 'GitRepository', 'Bucket')."

										enum: [
											"HelmRepository",
											"GitRepository",
											"Bucket",
										]
										type: "string"
									}
									name: {
										description: "Name of the referent."
										type:        "string"
									}
								}
								required: [
									"kind",
									"name",
								]
								type: "object"
							}
							suspend: {
								description: "This flag tells the controller to suspend the reconciliation of this source."

								type: "boolean"
							}
							valuesFile: {
								description: "Alternative values file to use as the default chart values, expected to be a relative path in the SourceRef. Deprecated in favor of ValuesFiles, for backwards compatibility the file defined here is merged before the ValuesFiles items. Ignored when omitted."

								type: "string"
							}
							valuesFiles: {
								description: "Alternative list of values files to use as the chart values (values.yaml is not included by default), expected to be a relative path in the SourceRef. Values files are merged in the order of this list with the last file overriding the first. Ignored when omitted."

								items: type: "string"
								type: "array"
							}
							version: {
								default:     "*"
								description: "The chart version semver expression, ignored for charts from GitRepository and Bucket sources. Defaults to latest when omitted."

								type: "string"
							}
						}
						required: [
							"chart",
							"interval",
							"sourceRef",
						]
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "HelmChartStatus defines the observed state of the HelmChart."
						properties: {
							artifact: {
								description: "Artifact represents the output of the last successful chart sync."

								properties: {
									checksum: {
										description: "Checksum is the SHA256 checksum of the artifact."
										type:        "string"
									}
									lastUpdateTime: {
										description: "LastUpdateTime is the timestamp corresponding to the last update of this artifact."

										format: "date-time"
										type:   "string"
									}
									path: {
										description: "Path is the relative file path of this artifact."
										type:        "string"
									}
									revision: {
										description: "Revision is a human readable identifier traceable in the origin source system. It can be a Git commit SHA, Git tag, a Helm index timestamp, a Helm chart version, etc."

										type: "string"
									}
									url: {
										description: "URL is the HTTP address of this artifact."
										type:        "string"
									}
								}
								required: [
									"path",
									"url",
								]
								type: "object"
							}
							conditions: {
								description: "Conditions holds the conditions for the HelmChart."
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							lastHandledReconcileAt: {
								description: "LastHandledReconcileAt holds the value of the most recent reconcile request value, so a change of the annotation value can be detected."

								type: "string"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last observed generation."
								format:      "int64"
								type:        "integer"
							}
							url: {
								description: "URL is the download link for the last chart pulled."
								type:        "string"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: false
			subresources: status: {}
		}, {
			additionalPrinterColumns: [{
				jsonPath: ".spec.chart"
				name:     "Chart"
				type:     "string"
			}, {
				jsonPath: ".spec.version"
				name:     "Version"
				type:     "string"
			}, {
				jsonPath: ".spec.sourceRef.kind"
				name:     "Source Kind"
				type:     "string"
			}, {
				jsonPath: ".spec.sourceRef.name"
				name:     "Source Name"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
				name:     "Ready"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
				name:     "Status"
				type:     "string"
			}]
			name: "v1beta2"
			schema: openAPIV3Schema: {
				description: "HelmChart is the Schema for the helmcharts API."
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "HelmChartSpec specifies the desired state of a Helm chart."
						properties: {
							accessFrom: {
								description: "AccessFrom specifies an Access Control List for allowing cross-namespace references to this object. NOTE: Not implemented, provisional as of https://github.com/fluxcd/flux2/pull/2092"

								properties: namespaceSelectors: {
									description: "NamespaceSelectors is the list of namespace selectors to which this ACL applies. Items in this list are evaluated using a logical OR operation."

									items: {
										description: "NamespaceSelector selects the namespaces to which this ACL applies. An empty map of MatchLabels matches all namespaces in a cluster."

										properties: matchLabels: {
											additionalProperties: type: "string"
											description: "MatchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."

											type: "object"
										}
										type: "object"
									}
									type: "array"
								}
								required: ["namespaceSelectors"]
								type: "object"
							}
							chart: {
								description: "Chart is the name or path the Helm chart is available at in the SourceRef."

								type: "string"
							}
							interval: {
								description: "Interval at which the HelmChart SourceRef is checked for updates. This interval is approximate and may be subject to jitter to ensure efficient use of resources."

								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
								type:    "string"
							}
							reconcileStrategy: {
								default:     "ChartVersion"
								description: "ReconcileStrategy determines what enables the creation of a new artifact. Valid values are ('ChartVersion', 'Revision'). See the documentation of the values for an explanation on their behavior. Defaults to ChartVersion when omitted."

								enum: [
									"ChartVersion",
									"Revision",
								]
								type: "string"
							}
							sourceRef: {
								description: "SourceRef is the reference to the Source the chart is available at."

								properties: {
									apiVersion: {
										description: "APIVersion of the referent."
										type:        "string"
									}
									kind: {
										description: "Kind of the referent, valid values are ('HelmRepository', 'GitRepository', 'Bucket')."

										enum: [
											"HelmRepository",
											"GitRepository",
											"Bucket",
										]
										type: "string"
									}
									name: {
										description: "Name of the referent."
										type:        "string"
									}
								}
								required: [
									"kind",
									"name",
								]
								type: "object"
							}
							suspend: {
								description: "Suspend tells the controller to suspend the reconciliation of this source."

								type: "boolean"
							}
							valuesFile: {
								description: "ValuesFile is an alternative values file to use as the default chart values, expected to be a relative path in the SourceRef. Deprecated in favor of ValuesFiles, for backwards compatibility the file specified here is merged before the ValuesFiles items. Ignored when omitted."

								type: "string"
							}
							valuesFiles: {
								description: "ValuesFiles is an alternative list of values files to use as the chart values (values.yaml is not included by default), expected to be a relative path in the SourceRef. Values files are merged in the order of this list with the last file overriding the first. Ignored when omitted."

								items: type: "string"
								type: "array"
							}
							verify: {
								description: "Verify contains the secret name containing the trusted public keys used to verify the signature and specifies which provider to use to check whether OCI image is authentic. This field is only supported when using HelmRepository source with spec.type 'oci'. Chart dependencies, which are not bundled in the umbrella chart artifact, are not verified."

								properties: {
									matchOIDCIdentity: {
										description: "MatchOIDCIdentity specifies the identity matching criteria to use while verifying an OCI artifact which was signed using Cosign keyless signing. The artifact's identity is deemed to be verified if any of the specified matchers match against the identity."

										items: {
											description: "OIDCIdentityMatch specifies options for verifying the certificate identity, i.e. the issuer and the subject of the certificate."

											properties: {
												issuer: {
													description: "Issuer specifies the regex pattern to match against to verify the OIDC issuer in the Fulcio certificate. The pattern must be a valid Go regular expression."

													type: "string"
												}
												subject: {
													description: "Subject specifies the regex pattern to match against to verify the identity subject in the Fulcio certificate. The pattern must be a valid Go regular expression."

													type: "string"
												}
											}
											required: [
												"issuer",
												"subject",
											]
											type: "object"
										}
										type: "array"
									}
									provider: {
										default:     "cosign"
										description: "Provider specifies the technology used to sign the OCI Artifact."

										enum: ["cosign"]
										type: "string"
									}
									secretRef: {
										description: "SecretRef specifies the Kubernetes Secret containing the trusted public keys."

										properties: name: {
											description: "Name of the referent."
											type:        "string"
										}
										required: ["name"]
										type: "object"
									}
								}
								required: ["provider"]
								type: "object"
							}
							version: {
								default:     "*"
								description: "Version is the chart version semver expression, ignored for charts from GitRepository and Bucket sources. Defaults to latest when omitted."

								type: "string"
							}
						}
						required: [
							"chart",
							"interval",
							"sourceRef",
						]
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "HelmChartStatus records the observed state of the HelmChart."
						properties: {
							artifact: {
								description: "Artifact represents the output of the last successful reconciliation."

								properties: {
									digest: {
										description: "Digest is the digest of the file in the form of '<algorithm>:<checksum>'."
										pattern:     "^[a-z0-9]+(?:[.+_-][a-z0-9]+)*:[a-zA-Z0-9=_-]+$"
										type:        "string"
									}
									lastUpdateTime: {
										description: "LastUpdateTime is the timestamp corresponding to the last update of the Artifact."

										format: "date-time"
										type:   "string"
									}
									metadata: {
										additionalProperties: type: "string"
										description: "Metadata holds upstream information such as OCI annotations."
										type:        "object"
									}
									path: {
										description: "Path is the relative file path of the Artifact. It can be used to locate the file in the root of the Artifact storage on the local file system of the controller managing the Source."

										type: "string"
									}
									revision: {
										description: "Revision is a human-readable identifier traceable in the origin source system. It can be a Git commit SHA, Git tag, a Helm chart version, etc."

										type: "string"
									}
									size: {
										description: "Size is the number of bytes in the file."
										format:      "int64"
										type:        "integer"
									}
									url: {
										description: "URL is the HTTP address of the Artifact as exposed by the controller managing the Source. It can be used to retrieve the Artifact for consumption, e.g. by another controller applying the Artifact contents."

										type: "string"
									}
								}
								required: [
									"lastUpdateTime",
									"path",
									"revision",
									"url",
								]
								type: "object"
							}
							conditions: {
								description: "Conditions holds the conditions for the HelmChart."
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							lastHandledReconcileAt: {
								description: "LastHandledReconcileAt holds the value of the most recent reconcile request value, so a change of the annotation value can be detected."

								type: "string"
							}
							observedChartName: {
								description: "ObservedChartName is the last observed chart name as specified by the resolved chart reference."

								type: "string"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last observed generation of the HelmChart object."

								format: "int64"
								type:   "integer"
							}
							observedSourceArtifactRevision: {
								description: "ObservedSourceArtifactRevision is the last observed Artifact.Revision of the HelmChartSpec.SourceRef."

								type: "string"
							}
							url: {
								description: "URL is the dynamic fetch link for the latest Artifact. It is provided on a \"best effort\" basis, and using the precise BucketStatus.Artifact data is recommended."

								type: "string"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}
customresourcedefinition: "helmreleases.helm.toolkit.fluxcd.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.12.0"
		name: "helmreleases.helm.toolkit.fluxcd.io"
	}
	spec: {
		group: "helm.toolkit.fluxcd.io"
		names: {
			kind:     "HelmRelease"
			listKind: "HelmReleaseList"
			plural:   "helmreleases"
			shortNames: ["hr"]
			singular: "helmrelease"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
				name:     "Ready"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
				name:     "Status"
				type:     "string"
			}]
			deprecated:         true
			deprecationWarning: "v2beta1 HelmRelease is deprecated, upgrade to v2beta2"
			name:               "v2beta1"
			schema: openAPIV3Schema: {
				description: "HelmRelease is the Schema for the helmreleases API"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "HelmReleaseSpec defines the desired state of a Helm release."
						properties: {
							chart: {
								description: "Chart defines the template of the v1beta2.HelmChart that should be created for this HelmRelease."

								properties: {
									metadata: {
										description: "ObjectMeta holds the template for metadata like labels and annotations."

										properties: {
											annotations: {
												additionalProperties: type: "string"
												description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/"

												type: "object"
											}
											labels: {
												additionalProperties: type: "string"
												description: "Map of string keys and values that can be used to organize and categorize (scope and select) objects. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/"

												type: "object"
											}
										}
										type: "object"
									}
									spec: {
										description: "Spec holds the template for the v1beta2.HelmChartSpec for this HelmRelease."

										properties: {
											chart: {
												description: "The name or path the Helm chart is available at in the SourceRef."

												type: "string"
											}
											interval: {
												description: "Interval at which to check the v1beta2.Source for updates. Defaults to 'HelmReleaseSpec.Interval'."

												pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
												type:    "string"
											}
											reconcileStrategy: {
												default:     "ChartVersion"
												description: "Determines what enables the creation of a new artifact. Valid values are ('ChartVersion', 'Revision'). See the documentation of the values for an explanation on their behavior. Defaults to ChartVersion when omitted."

												enum: [
													"ChartVersion",
													"Revision",
												]
												type: "string"
											}
											sourceRef: {
												description: "The name and namespace of the v1beta2.Source the chart is available at."

												properties: {
													apiVersion: {
														description: "APIVersion of the referent."
														type:        "string"
													}
													kind: {
														description: "Kind of the referent."
														enum: [
															"HelmRepository",
															"GitRepository",
															"Bucket",
														]
														type: "string"
													}
													name: {
														description: "Name of the referent."
														maxLength:   253
														minLength:   1
														type:        "string"
													}
													namespace: {
														description: "Namespace of the referent."
														maxLength:   63
														minLength:   1
														type:        "string"
													}
												}
												required: ["name"]
												type: "object"
											}
											valuesFile: {
												description: "Alternative values file to use as the default chart values, expected to be a relative path in the SourceRef. Deprecated in favor of ValuesFiles, for backwards compatibility the file defined here is merged before the ValuesFiles items. Ignored when omitted."

												type: "string"
											}
											valuesFiles: {
												description: "Alternative list of values files to use as the chart values (values.yaml is not included by default), expected to be a relative path in the SourceRef. Values files are merged in the order of this list with the last file overriding the first. Ignored when omitted."

												items: type: "string"
												type: "array"
											}
											verify: {
												description: "Verify contains the secret name containing the trusted public keys used to verify the signature and specifies which provider to use to check whether OCI image is authentic. This field is only supported for OCI sources. Chart dependencies, which are not bundled in the umbrella chart artifact, are not verified."

												properties: {
													provider: {
														default:     "cosign"
														description: "Provider specifies the technology used to sign the OCI Helm chart."

														enum: ["cosign"]
														type: "string"
													}
													secretRef: {
														description: "SecretRef specifies the Kubernetes Secret containing the trusted public keys."

														properties: name: {
															description: "Name of the referent."
															type:        "string"
														}
														required: ["name"]
														type: "object"
													}
												}
												required: ["provider"]
												type: "object"
											}
											version: {
												default:     "*"
												description: "Version semver expression, ignored for charts from v1beta2.GitRepository and v1beta2.Bucket sources. Defaults to latest when omitted."

												type: "string"
											}
										}
										required: [
											"chart",
											"sourceRef",
										]
										type: "object"
									}
								}
								required: ["spec"]
								type: "object"
							}
							dependsOn: {
								description: "DependsOn may contain a meta.NamespacedObjectReference slice with references to HelmRelease resources that must be ready before this HelmRelease can be reconciled."

								items: {
									description: "NamespacedObjectReference contains enough information to locate the referenced Kubernetes resource object in any namespace."

									properties: {
										name: {
											description: "Name of the referent."
											type:        "string"
										}
										namespace: {
											description: "Namespace of the referent, when not specified it acts as LocalObjectReference."

											type: "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								type: "array"
							}
							driftDetection: {
								description: """
		DriftDetection holds the configuration for detecting and handling differences between the manifest in the Helm storage and the resources currently existing in the cluster. 
		 Note: this field is provisional to the v2beta2 API, and not actively used by v2beta1 HelmReleases.
		"""

								properties: {
									ignore: {
										description: "Ignore contains a list of rules for specifying which changes to ignore during diffing."

										items: {
											description: "IgnoreRule defines a rule to selectively disregard specific changes during the drift detection process."

											properties: {
												paths: {
													description: "Paths is a list of JSON Pointer (RFC 6901) paths to be excluded from consideration in a Kubernetes object."

													items: type: "string"
													type: "array"
												}
												target: {
													description: "Target is a selector for specifying Kubernetes objects to which this rule applies. If Target is not set, the Paths will be ignored for all Kubernetes objects within the manifest of the Helm release."

													properties: {
														annotationSelector: {
															description: "AnnotationSelector is a string that follows the label selection expression https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api It matches with the resource annotations."

															type: "string"
														}
														group: {
															description: "Group is the API group to select resources from. Together with Version and Kind it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

															type: "string"
														}
														kind: {
															description: "Kind of the API Group to select resources from. Together with Group and Version it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

															type: "string"
														}
														labelSelector: {
															description: "LabelSelector is a string that follows the label selection expression https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api It matches with the resource labels."

															type: "string"
														}
														name: {
															description: "Name to match resources with."
															type:        "string"
														}
														namespace: {
															description: "Namespace to select resources from."
															type:        "string"
														}
														version: {
															description: "Version of the API Group to select resources from. Together with Group and Kind it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

															type: "string"
														}
													}
													type: "object"
												}
											}
											required: ["paths"]
											type: "object"
										}
										type: "array"
									}
									mode: {
										description: "Mode defines how differences should be handled between the Helm manifest and the manifest currently applied to the cluster. If not explicitly set, it defaults to DiffModeDisabled."

										enum: [
											"enabled",
											"warn",
											"disabled",
										]
										type: "string"
									}
								}
								type: "object"
							}
							install: {
								description: "Install holds the configuration for Helm install actions for this HelmRelease."

								properties: {
									crds: {
										description: """
		CRDs upgrade CRDs from the Helm Chart's crds directory according to the CRD upgrade policy provided here. Valid values are `Skip`, `Create` or `CreateReplace`. Default is `Create` and if omitted CRDs are installed but not updated. 
		 Skip: do neither install nor replace (update) any CRDs. 
		 Create: new CRDs are created, existing CRDs are neither updated nor deleted. 
		 CreateReplace: new CRDs are created, existing CRDs are updated (replaced) but not deleted. 
		 By default, CRDs are applied (installed) during Helm install action. With this option users can opt-in to CRD replace existing CRDs on Helm install actions, which is not (yet) natively supported by Helm. https://helm.sh/docs/chart_best_practices/custom_resource_definitions.
		"""

										enum: [
											"Skip",
											"Create",
											"CreateReplace",
										]
										type: "string"
									}
									createNamespace: {
										description: "CreateNamespace tells the Helm install action to create the HelmReleaseSpec.TargetNamespace if it does not exist yet. On uninstall, the namespace will not be garbage collected."

										type: "boolean"
									}
									disableHooks: {
										description: "DisableHooks prevents hooks from running during the Helm install action."

										type: "boolean"
									}
									disableOpenAPIValidation: {
										description: "DisableOpenAPIValidation prevents the Helm install action from validating rendered templates against the Kubernetes OpenAPI Schema."

										type: "boolean"
									}
									disableWait: {
										description: "DisableWait disables the waiting for resources to be ready after a Helm install has been performed."

										type: "boolean"
									}
									disableWaitForJobs: {
										description: "DisableWaitForJobs disables waiting for jobs to complete after a Helm install has been performed."

										type: "boolean"
									}
									remediation: {
										description: "Remediation holds the remediation configuration for when the Helm install action for the HelmRelease fails. The default is to not perform any action."

										properties: {
											ignoreTestFailures: {
												description: "IgnoreTestFailures tells the controller to skip remediation when the Helm tests are run after an install action but fail. Defaults to 'Test.IgnoreFailures'."

												type: "boolean"
											}
											remediateLastFailure: {
												description: "RemediateLastFailure tells the controller to remediate the last failure, when no retries remain. Defaults to 'false'."

												type: "boolean"
											}
											retries: {
												description: "Retries is the number of retries that should be attempted on failures before bailing. Remediation, using an uninstall, is performed between each attempt. Defaults to '0', a negative integer equals to unlimited retries."

												type: "integer"
											}
										}
										type: "object"
									}
									replace: {
										description: "Replace tells the Helm install action to re-use the 'ReleaseName', but only if that name is a deleted release which remains in the history."

										type: "boolean"
									}
									skipCRDs: {
										description: """
		SkipCRDs tells the Helm install action to not install any CRDs. By default, CRDs are installed if not already present. 
		 Deprecated use CRD policy (`crds`) attribute with value `Skip` instead.
		"""

										type: "boolean"
									}
									timeout: {
										description: "Timeout is the time to wait for any individual Kubernetes operation (like Jobs for hooks) during the performance of a Helm install action. Defaults to 'HelmReleaseSpec.Timeout'."

										pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
										type:    "string"
									}
								}
								type: "object"
							}
							interval: {
								description: "Interval at which to reconcile the Helm release. This interval is approximate and may be subject to jitter to ensure efficient use of resources."

								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
								type:    "string"
							}
							kubeConfig: {
								description: "KubeConfig for reconciling the HelmRelease on a remote cluster. When used in combination with HelmReleaseSpec.ServiceAccountName, forces the controller to act on behalf of that Service Account at the target cluster. If the --default-service-account flag is set, its value will be used as a controller level fallback for when HelmReleaseSpec.ServiceAccountName is empty."

								properties: secretRef: {
									description: "SecretRef holds the name of a secret that contains a key with the kubeconfig file as the value. If no key is set, the key will default to 'value'. It is recommended that the kubeconfig is self-contained, and the secret is regularly updated if credentials such as a cloud-access-token expire. Cloud specific `cmd-path` auth helpers will not function without adding binaries and credentials to the Pod that is responsible for reconciling Kubernetes resources."

									properties: {
										key: {
											description: "Key in the Secret, when not specified an implementation-specific default key is used."

											type: "string"
										}
										name: {
											description: "Name of the Secret."
											type:        "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								required: ["secretRef"]
								type: "object"
							}
							maxHistory: {
								description: "MaxHistory is the number of revisions saved by Helm for this HelmRelease. Use '0' for an unlimited number of revisions; defaults to '10'."

								type: "integer"
							}
							persistentClient: {
								description: """
		PersistentClient tells the controller to use a persistent Kubernetes client for this release. When enabled, the client will be reused for the duration of the reconciliation, instead of being created and destroyed for each (step of a) Helm action. 
		 This can improve performance, but may cause issues with some Helm charts that for example do create Custom Resource Definitions during installation outside Helm's CRD lifecycle hooks, which are then not observed to be available by e.g. post-install hooks. 
		 If not set, it defaults to true.
		"""

								type: "boolean"
							}
							postRenderers: {
								description: "PostRenderers holds an array of Helm PostRenderers, which will be applied in order of their definition."

								items: {
									description: "PostRenderer contains a Helm PostRenderer specification."
									properties: kustomize: {
										description: "Kustomization to apply as PostRenderer."
										properties: {
											images: {
												description: "Images is a list of (image name, new name, new tag or digest) for changing image names, tags or digests. This can also be achieved with a patch, but this operator is simpler to specify."

												items: {
													description: "Image contains an image name, a new name, a new tag or digest, which will replace the original name and tag."

													properties: {
														digest: {
															description: "Digest is the value used to replace the original image tag. If digest is present NewTag value is ignored."

															type: "string"
														}
														name: {
															description: "Name is a tag-less image name."
															type:        "string"
														}
														newName: {
															description: "NewName is the value used to replace the original name."

															type: "string"
														}
														newTag: {
															description: "NewTag is the value used to replace the original tag."

															type: "string"
														}
													}
													required: ["name"]
													type: "object"
												}
												type: "array"
											}
											patches: {
												description: "Strategic merge and JSON patches, defined as inline YAML objects, capable of targeting objects based on kind, label and annotation selectors."

												items: {
													description: "Patch contains an inline StrategicMerge or JSON6902 patch, and the target the patch should be applied to."

													properties: {
														patch: {
															description: "Patch contains an inline StrategicMerge patch or an inline JSON6902 patch with an array of operation objects."

															type: "string"
														}
														target: {
															description: "Target points to the resources that the patch document should be applied to."

															properties: {
																annotationSelector: {
																	description: "AnnotationSelector is a string that follows the label selection expression https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api It matches with the resource annotations."

																	type: "string"
																}
																group: {
																	description: "Group is the API group to select resources from. Together with Version and Kind it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

																	type: "string"
																}
																kind: {
																	description: "Kind of the API Group to select resources from. Together with Group and Version it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

																	type: "string"
																}
																labelSelector: {
																	description: "LabelSelector is a string that follows the label selection expression https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api It matches with the resource labels."

																	type: "string"
																}
																name: {
																	description: "Name to match resources with."
																	type:        "string"
																}
																namespace: {
																	description: "Namespace to select resources from."
																	type:        "string"
																}
																version: {
																	description: "Version of the API Group to select resources from. Together with Group and Kind it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

																	type: "string"
																}
															}
															type: "object"
														}
													}
													required: ["patch"]
													type: "object"
												}
												type: "array"
											}
											patchesJson6902: {
												description: "JSON 6902 patches, defined as inline YAML objects."
												items: {
													description: "JSON6902Patch contains a JSON6902 patch and the target the patch should be applied to."

													properties: {
														patch: {
															description: "Patch contains the JSON6902 patch document with an array of operation objects."

															items: {
																description: "JSON6902 is a JSON6902 operation object. https://datatracker.ietf.org/doc/html/rfc6902#section-4"

																properties: {
																	from: {
																		description: "From contains a JSON-pointer value that references a location within the target document where the operation is performed. The meaning of the value depends on the value of Op, and is NOT taken into account by all operations."

																		type: "string"
																	}
																	op: {
																		description: "Op indicates the operation to perform. Its value MUST be one of \"add\", \"remove\", \"replace\", \"move\", \"copy\", or \"test\". https://datatracker.ietf.org/doc/html/rfc6902#section-4"

																		enum: [
																			"test",
																			"remove",
																			"add",
																			"replace",
																			"move",
																			"copy",
																		]
																		type: "string"
																	}
																	path: {
																		description: "Path contains the JSON-pointer value that references a location within the target document where the operation is performed. The meaning of the value depends on the value of Op."

																		type: "string"
																	}
																	value: {
																		description: "Value contains a valid JSON structure. The meaning of the value depends on the value of Op, and is NOT taken into account by all operations."

																		"x-kubernetes-preserve-unknown-fields": true
																	}
																}
																required: [
																	"op",
																	"path",
																]
																type: "object"
															}
															type: "array"
														}
														target: {
															description: "Target points to the resources that the patch document should be applied to."

															properties: {
																annotationSelector: {
																	description: "AnnotationSelector is a string that follows the label selection expression https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api It matches with the resource annotations."

																	type: "string"
																}
																group: {
																	description: "Group is the API group to select resources from. Together with Version and Kind it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

																	type: "string"
																}
																kind: {
																	description: "Kind of the API Group to select resources from. Together with Group and Version it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

																	type: "string"
																}
																labelSelector: {
																	description: "LabelSelector is a string that follows the label selection expression https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api It matches with the resource labels."

																	type: "string"
																}
																name: {
																	description: "Name to match resources with."
																	type:        "string"
																}
																namespace: {
																	description: "Namespace to select resources from."
																	type:        "string"
																}
																version: {
																	description: "Version of the API Group to select resources from. Together with Group and Kind it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

																	type: "string"
																}
															}
															type: "object"
														}
													}
													required: [
														"patch",
														"target",
													]
													type: "object"
												}
												type: "array"
											}
											patchesStrategicMerge: {
												description: "Strategic merge patches, defined as inline YAML objects."

												items: "x-kubernetes-preserve-unknown-fields": true
												type: "array"
											}
										}
										type: "object"
									}
									type: "object"
								}
								type: "array"
							}
							releaseName: {
								description: "ReleaseName used for the Helm release. Defaults to a composition of '[TargetNamespace-]Name'."

								maxLength: 53
								minLength: 1
								type:      "string"
							}
							rollback: {
								description: "Rollback holds the configuration for Helm rollback actions for this HelmRelease."

								properties: {
									cleanupOnFail: {
										description: "CleanupOnFail allows deletion of new resources created during the Helm rollback action when it fails."

										type: "boolean"
									}
									disableHooks: {
										description: "DisableHooks prevents hooks from running during the Helm rollback action."

										type: "boolean"
									}
									disableWait: {
										description: "DisableWait disables the waiting for resources to be ready after a Helm rollback has been performed."

										type: "boolean"
									}
									disableWaitForJobs: {
										description: "DisableWaitForJobs disables waiting for jobs to complete after a Helm rollback has been performed."

										type: "boolean"
									}
									force: {
										description: "Force forces resource updates through a replacement strategy."

										type: "boolean"
									}
									recreate: {
										description: "Recreate performs pod restarts for the resource if applicable."

										type: "boolean"
									}
									timeout: {
										description: "Timeout is the time to wait for any individual Kubernetes operation (like Jobs for hooks) during the performance of a Helm rollback action. Defaults to 'HelmReleaseSpec.Timeout'."

										pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
										type:    "string"
									}
								}
								type: "object"
							}
							serviceAccountName: {
								description: "The name of the Kubernetes service account to impersonate when reconciling this HelmRelease."

								type: "string"
							}
							storageNamespace: {
								description: "StorageNamespace used for the Helm storage. Defaults to the namespace of the HelmRelease."

								maxLength: 63
								minLength: 1
								type:      "string"
							}
							suspend: {
								description: "Suspend tells the controller to suspend reconciliation for this HelmRelease, it does not apply to already started reconciliations. Defaults to false."

								type: "boolean"
							}
							targetNamespace: {
								description: "TargetNamespace to target when performing operations for the HelmRelease. Defaults to the namespace of the HelmRelease."

								maxLength: 63
								minLength: 1
								type:      "string"
							}
							test: {
								description: "Test holds the configuration for Helm test actions for this HelmRelease."

								properties: {
									enable: {
										description: "Enable enables Helm test actions for this HelmRelease after an Helm install or upgrade action has been performed."

										type: "boolean"
									}
									ignoreFailures: {
										description: "IgnoreFailures tells the controller to skip remediation when the Helm tests are run but fail. Can be overwritten for tests run after install or upgrade actions in 'Install.IgnoreTestFailures' and 'Upgrade.IgnoreTestFailures'."

										type: "boolean"
									}
									timeout: {
										description: "Timeout is the time to wait for any individual Kubernetes operation during the performance of a Helm test action. Defaults to 'HelmReleaseSpec.Timeout'."

										pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
										type:    "string"
									}
								}
								type: "object"
							}
							timeout: {
								description: "Timeout is the time to wait for any individual Kubernetes operation (like Jobs for hooks) during the performance of a Helm action. Defaults to '5m0s'."

								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
								type:    "string"
							}
							uninstall: {
								description: "Uninstall holds the configuration for Helm uninstall actions for this HelmRelease."

								properties: {
									deletionPropagation: {
										default:     "background"
										description: "DeletionPropagation specifies the deletion propagation policy when a Helm uninstall is performed."

										enum: [
											"background",
											"foreground",
											"orphan",
										]
										type: "string"
									}
									disableHooks: {
										description: "DisableHooks prevents hooks from running during the Helm rollback action."

										type: "boolean"
									}
									disableWait: {
										description: "DisableWait disables waiting for all the resources to be deleted after a Helm uninstall is performed."

										type: "boolean"
									}
									keepHistory: {
										description: "KeepHistory tells Helm to remove all associated resources and mark the release as deleted, but retain the release history."

										type: "boolean"
									}
									timeout: {
										description: "Timeout is the time to wait for any individual Kubernetes operation (like Jobs for hooks) during the performance of a Helm uninstall action. Defaults to 'HelmReleaseSpec.Timeout'."

										pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
										type:    "string"
									}
								}
								type: "object"
							}
							upgrade: {
								description: "Upgrade holds the configuration for Helm upgrade actions for this HelmRelease."

								properties: {
									cleanupOnFail: {
										description: "CleanupOnFail allows deletion of new resources created during the Helm upgrade action when it fails."

										type: "boolean"
									}
									crds: {
										description: """
		CRDs upgrade CRDs from the Helm Chart's crds directory according to the CRD upgrade policy provided here. Valid values are `Skip`, `Create` or `CreateReplace`. Default is `Skip` and if omitted CRDs are neither installed nor upgraded. 
		 Skip: do neither install nor replace (update) any CRDs. 
		 Create: new CRDs are created, existing CRDs are neither updated nor deleted. 
		 CreateReplace: new CRDs are created, existing CRDs are updated (replaced) but not deleted. 
		 By default, CRDs are not applied during Helm upgrade action. With this option users can opt-in to CRD upgrade, which is not (yet) natively supported by Helm. https://helm.sh/docs/chart_best_practices/custom_resource_definitions.
		"""

										enum: [
											"Skip",
											"Create",
											"CreateReplace",
										]
										type: "string"
									}
									disableHooks: {
										description: "DisableHooks prevents hooks from running during the Helm upgrade action."

										type: "boolean"
									}
									disableOpenAPIValidation: {
										description: "DisableOpenAPIValidation prevents the Helm upgrade action from validating rendered templates against the Kubernetes OpenAPI Schema."

										type: "boolean"
									}
									disableWait: {
										description: "DisableWait disables the waiting for resources to be ready after a Helm upgrade has been performed."

										type: "boolean"
									}
									disableWaitForJobs: {
										description: "DisableWaitForJobs disables waiting for jobs to complete after a Helm upgrade has been performed."

										type: "boolean"
									}
									force: {
										description: "Force forces resource updates through a replacement strategy."

										type: "boolean"
									}
									preserveValues: {
										description: "PreserveValues will make Helm reuse the last release's values and merge in overrides from 'Values'. Setting this flag makes the HelmRelease non-declarative."

										type: "boolean"
									}
									remediation: {
										description: "Remediation holds the remediation configuration for when the Helm upgrade action for the HelmRelease fails. The default is to not perform any action."

										properties: {
											ignoreTestFailures: {
												description: "IgnoreTestFailures tells the controller to skip remediation when the Helm tests are run after an upgrade action but fail. Defaults to 'Test.IgnoreFailures'."

												type: "boolean"
											}
											remediateLastFailure: {
												description: "RemediateLastFailure tells the controller to remediate the last failure, when no retries remain. Defaults to 'false' unless 'Retries' is greater than 0."

												type: "boolean"
											}
											retries: {
												description: "Retries is the number of retries that should be attempted on failures before bailing. Remediation, using 'Strategy', is performed between each attempt. Defaults to '0', a negative integer equals to unlimited retries."

												type: "integer"
											}
											strategy: {
												description: "Strategy to use for failure remediation. Defaults to 'rollback'."

												enum: [
													"rollback",
													"uninstall",
												]
												type: "string"
											}
										}
										type: "object"
									}
									timeout: {
										description: "Timeout is the time to wait for any individual Kubernetes operation (like Jobs for hooks) during the performance of a Helm upgrade action. Defaults to 'HelmReleaseSpec.Timeout'."

										pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
										type:    "string"
									}
								}
								type: "object"
							}
							values: {
								description:                            "Values holds the values for this Helm release."
								"x-kubernetes-preserve-unknown-fields": true
							}
							valuesFrom: {
								description: "ValuesFrom holds references to resources containing Helm values for this HelmRelease, and information about how they should be merged."

								items: {
									description: "ValuesReference contains a reference to a resource containing Helm values, and optionally the key they can be found at."

									properties: {
										kind: {
											description: "Kind of the values referent, valid values are ('Secret', 'ConfigMap')."

											enum: [
												"Secret",
												"ConfigMap",
											]
											type: "string"
										}
										name: {
											description: "Name of the values referent. Should reside in the same namespace as the referring resource."

											maxLength: 253
											minLength: 1
											type:      "string"
										}
										optional: {
											description: "Optional marks this ValuesReference as optional. When set, a not found error for the values reference is ignored, but any ValuesKey, TargetPath or transient error will still result in a reconciliation failure."

											type: "boolean"
										}
										targetPath: {
											description: "TargetPath is the YAML dot notation path the value should be merged at. When set, the ValuesKey is expected to be a single flat value. Defaults to 'None', which results in the values getting merged at the root."

											maxLength: 250
											pattern:   "^([a-zA-Z0-9_\\-.\\\\\\/]|\\[[0-9]{1,5}\\])+$"
											type:      "string"
										}
										valuesKey: {
											description: "ValuesKey is the data key where the values.yaml or a specific value can be found at. Defaults to 'values.yaml'. When set, must be a valid Data Key, consisting of alphanumeric characters, '-', '_' or '.'."

											maxLength: 253
											pattern:   "^[\\-._a-zA-Z0-9]+$"
											type:      "string"
										}
									}
									required: [
										"kind",
										"name",
									]
									type: "object"
								}
								type: "array"
							}
						}
						required: [
							"chart",
							"interval",
						]
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "HelmReleaseStatus defines the observed state of a HelmRelease."
						properties: {
							conditions: {
								description: "Conditions holds the conditions for the HelmRelease."
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							failures: {
								description: "Failures is the reconciliation failure count against the latest desired state. It is reset after a successful reconciliation."

								format: "int64"
								type:   "integer"
							}
							helmChart: {
								description: "HelmChart is the namespaced name of the HelmChart resource created by the controller for the HelmRelease."

								type: "string"
							}
							history: {
								description: """
		History holds the history of Helm releases performed for this HelmRelease up to the last successfully completed release. 
		 Note: this field is provisional to the v2beta2 API, and not actively used by v2beta1 HelmReleases.
		"""

								items: {
									description: "Snapshot captures a point-in-time copy of the status information for a Helm release, as managed by the controller."

									properties: {
										apiVersion: {
											description: "APIVersion is the API version of the Snapshot. Provisional: when the calculation method of the Digest field is changed, this field will be used to distinguish between the old and new methods."

											type: "string"
										}
										chartName: {
											description: "ChartName is the chart name of the release object in storage."

											type: "string"
										}
										chartVersion: {
											description: "ChartVersion is the chart version of the release object in storage."

											type: "string"
										}
										configDigest: {
											description: "ConfigDigest is the checksum of the config (better known as \"values\") of the release object in storage. It has the format of `<algo>:<checksum>`."

											type: "string"
										}
										deleted: {
											description: "Deleted is when the release was deleted."
											format:      "date-time"
											type:        "string"
										}
										digest: {
											description: "Digest is the checksum of the release object in storage. It has the format of `<algo>:<checksum>`."

											type: "string"
										}
										firstDeployed: {
											description: "FirstDeployed is when the release was first deployed."
											format:      "date-time"
											type:        "string"
										}
										lastDeployed: {
											description: "LastDeployed is when the release was last deployed."
											format:      "date-time"
											type:        "string"
										}
										name: {
											description: "Name is the name of the release."
											type:        "string"
										}
										namespace: {
											description: "Namespace is the namespace the release is deployed to."

											type: "string"
										}
										status: {
											description: "Status is the current state of the release."
											type:        "string"
										}
										testHooks: {
											additionalProperties: {
												description: "TestHookStatus holds the status information for a test hook as observed to be run by the controller."

												properties: {
													lastCompleted: {
														description: "LastCompleted is the time the test hook last completed."

														format: "date-time"
														type:   "string"
													}
													lastStarted: {
														description: "LastStarted is the time the test hook was last started."

														format: "date-time"
														type:   "string"
													}
													phase: {
														description: "Phase the test hook was observed to be in."
														type:        "string"
													}
												}
												type: "object"
											}
											description: "TestHooks is the list of test hooks for the release as observed to be run by the controller."

											type: "object"
										}
										version: {
											description: "Version is the version of the release object in storage."

											type: "integer"
										}
									}
									required: [
										"chartName",
										"chartVersion",
										"configDigest",
										"digest",
										"firstDeployed",
										"lastDeployed",
										"name",
										"namespace",
										"status",
										"version",
									]
									type: "object"
								}
								type: "array"
							}
							installFailures: {
								description: "InstallFailures is the install failure count against the latest desired state. It is reset after a successful reconciliation."

								format: "int64"
								type:   "integer"
							}
							lastAppliedRevision: {
								description: "LastAppliedRevision is the revision of the last successfully applied source."

								type: "string"
							}
							lastAttemptedConfigDigest: {
								description: """
		LastAttemptedConfigDigest is the digest for the config (better known as \"values\") of the last reconciliation attempt. 
		 Note: this field is provisional to the v2beta2 API, and not actively used by v2beta1 HelmReleases.
		"""

								type: "string"
							}
							lastAttemptedGeneration: {
								description: """
		LastAttemptedGeneration is the last generation the controller attempted to reconcile. 
		 Note: this field is provisional to the v2beta2 API, and not actively used by v2beta1 HelmReleases.
		"""

								format: "int64"
								type:   "integer"
							}
							lastAttemptedReleaseAction: {
								description: """
		LastAttemptedReleaseAction is the last release action performed for this HelmRelease. It is used to determine the active remediation strategy. 
		 Note: this field is provisional to the v2beta2 API, and not actively used by v2beta1 HelmReleases.
		"""

								type: "string"
							}
							lastAttemptedRevision: {
								description: "LastAttemptedRevision is the revision of the last reconciliation attempt."

								type: "string"
							}
							lastAttemptedValuesChecksum: {
								description: "LastAttemptedValuesChecksum is the SHA1 checksum of the values of the last reconciliation attempt."

								type: "string"
							}
							lastHandledForceAt: {
								description: """
		LastHandledForceAt holds the value of the most recent force request value, so a change of the annotation value can be detected. 
		 Note: this field is provisional to the v2beta2 API, and not actively used by v2beta1 HelmReleases.
		"""

								type: "string"
							}
							lastHandledReconcileAt: {
								description: "LastHandledReconcileAt holds the value of the most recent reconcile request value, so a change of the annotation value can be detected."

								type: "string"
							}
							lastHandledResetAt: {
								description: """
		LastHandledResetAt holds the value of the most recent reset request value, so a change of the annotation value can be detected. 
		 Note: this field is provisional to the v2beta2 API, and not actively used by v2beta1 HelmReleases.
		"""

								type: "string"
							}
							lastReleaseRevision: {
								description: "LastReleaseRevision is the revision of the last successful Helm release."

								type: "integer"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last observed generation."
								format:      "int64"
								type:        "integer"
							}
							storageNamespace: {
								description: """
		StorageNamespace is the namespace of the Helm release storage for the current release. 
		 Note: this field is provisional to the v2beta2 API, and not actively used by v2beta1 HelmReleases.
		"""

								type: "string"
							}
							upgradeFailures: {
								description: "UpgradeFailures is the upgrade failure count against the latest desired state. It is reset after a successful reconciliation."

								format: "int64"
								type:   "integer"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: false
			subresources: status: {}
		}, {
			additionalPrinterColumns: [{
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
				name:     "Ready"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
				name:     "Status"
				type:     "string"
			}]
			name: "v2beta2"
			schema: openAPIV3Schema: {
				description: "HelmRelease is the Schema for the helmreleases API"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "HelmReleaseSpec defines the desired state of a Helm release."
						properties: {
							chart: {
								description: "Chart defines the template of the v1beta2.HelmChart that should be created for this HelmRelease."

								properties: {
									metadata: {
										description: "ObjectMeta holds the template for metadata like labels and annotations."

										properties: {
											annotations: {
												additionalProperties: type: "string"
												description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/"

												type: "object"
											}
											labels: {
												additionalProperties: type: "string"
												description: "Map of string keys and values that can be used to organize and categorize (scope and select) objects. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/"

												type: "object"
											}
										}
										type: "object"
									}
									spec: {
										description: "Spec holds the template for the v1beta2.HelmChartSpec for this HelmRelease."

										properties: {
											chart: {
												description: "The name or path the Helm chart is available at in the SourceRef."

												maxLength: 2048
												minLength: 1
												type:      "string"
											}
											interval: {
												description: "Interval at which to check the v1.Source for updates. Defaults to 'HelmReleaseSpec.Interval'."

												pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
												type:    "string"
											}
											reconcileStrategy: {
												default:     "ChartVersion"
												description: "Determines what enables the creation of a new artifact. Valid values are ('ChartVersion', 'Revision'). See the documentation of the values for an explanation on their behavior. Defaults to ChartVersion when omitted."

												enum: [
													"ChartVersion",
													"Revision",
												]
												type: "string"
											}
											sourceRef: {
												description: "The name and namespace of the v1.Source the chart is available at."

												properties: {
													apiVersion: {
														description: "APIVersion of the referent."
														type:        "string"
													}
													kind: {
														description: "Kind of the referent."
														enum: [
															"HelmRepository",
															"GitRepository",
															"Bucket",
														]
														type: "string"
													}
													name: {
														description: "Name of the referent."
														maxLength:   253
														minLength:   1
														type:        "string"
													}
													namespace: {
														description: "Namespace of the referent."
														maxLength:   63
														minLength:   1
														type:        "string"
													}
												}
												required: ["name"]
												type: "object"
											}
											valuesFile: {
												description: "Alternative values file to use as the default chart values, expected to be a relative path in the SourceRef. Deprecated in favor of ValuesFiles, for backwards compatibility the file defined here is merged before the ValuesFiles items. Ignored when omitted."

												type: "string"
											}
											valuesFiles: {
												description: "Alternative list of values files to use as the chart values (values.yaml is not included by default), expected to be a relative path in the SourceRef. Values files are merged in the order of this list with the last file overriding the first. Ignored when omitted."

												items: type: "string"
												type: "array"
											}
											verify: {
												description: "Verify contains the secret name containing the trusted public keys used to verify the signature and specifies which provider to use to check whether OCI image is authentic. This field is only supported for OCI sources. Chart dependencies, which are not bundled in the umbrella chart artifact, are not verified."

												properties: {
													provider: {
														default:     "cosign"
														description: "Provider specifies the technology used to sign the OCI Helm chart."

														enum: ["cosign"]
														type: "string"
													}
													secretRef: {
														description: "SecretRef specifies the Kubernetes Secret containing the trusted public keys."

														properties: name: {
															description: "Name of the referent."
															type:        "string"
														}
														required: ["name"]
														type: "object"
													}
												}
												required: ["provider"]
												type: "object"
											}
											version: {
												default:     "*"
												description: "Version semver expression, ignored for charts from v1beta2.GitRepository and v1beta2.Bucket sources. Defaults to latest when omitted."

												type: "string"
											}
										}
										required: [
											"chart",
											"sourceRef",
										]
										type: "object"
									}
								}
								required: ["spec"]
								type: "object"
							}
							dependsOn: {
								description: "DependsOn may contain a meta.NamespacedObjectReference slice with references to HelmRelease resources that must be ready before this HelmRelease can be reconciled."

								items: {
									description: "NamespacedObjectReference contains enough information to locate the referenced Kubernetes resource object in any namespace."

									properties: {
										name: {
											description: "Name of the referent."
											type:        "string"
										}
										namespace: {
											description: "Namespace of the referent, when not specified it acts as LocalObjectReference."

											type: "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								type: "array"
							}
							driftDetection: {
								description: "DriftDetection holds the configuration for detecting and handling differences between the manifest in the Helm storage and the resources currently existing in the cluster."

								properties: {
									ignore: {
										description: "Ignore contains a list of rules for specifying which changes to ignore during diffing."

										items: {
											description: "IgnoreRule defines a rule to selectively disregard specific changes during the drift detection process."

											properties: {
												paths: {
													description: "Paths is a list of JSON Pointer (RFC 6901) paths to be excluded from consideration in a Kubernetes object."

													items: type: "string"
													type: "array"
												}
												target: {
													description: "Target is a selector for specifying Kubernetes objects to which this rule applies. If Target is not set, the Paths will be ignored for all Kubernetes objects within the manifest of the Helm release."

													properties: {
														annotationSelector: {
															description: "AnnotationSelector is a string that follows the label selection expression https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api It matches with the resource annotations."

															type: "string"
														}
														group: {
															description: "Group is the API group to select resources from. Together with Version and Kind it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

															type: "string"
														}
														kind: {
															description: "Kind of the API Group to select resources from. Together with Group and Version it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

															type: "string"
														}
														labelSelector: {
															description: "LabelSelector is a string that follows the label selection expression https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api It matches with the resource labels."

															type: "string"
														}
														name: {
															description: "Name to match resources with."
															type:        "string"
														}
														namespace: {
															description: "Namespace to select resources from."
															type:        "string"
														}
														version: {
															description: "Version of the API Group to select resources from. Together with Group and Kind it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

															type: "string"
														}
													}
													type: "object"
												}
											}
											required: ["paths"]
											type: "object"
										}
										type: "array"
									}
									mode: {
										description: "Mode defines how differences should be handled between the Helm manifest and the manifest currently applied to the cluster. If not explicitly set, it defaults to DiffModeDisabled."

										enum: [
											"enabled",
											"warn",
											"disabled",
										]
										type: "string"
									}
								}
								type: "object"
							}
							install: {
								description: "Install holds the configuration for Helm install actions for this HelmRelease."

								properties: {
									crds: {
										description: """
		CRDs upgrade CRDs from the Helm Chart's crds directory according to the CRD upgrade policy provided here. Valid values are `Skip`, `Create` or `CreateReplace`. Default is `Create` and if omitted CRDs are installed but not updated. 
		 Skip: do neither install nor replace (update) any CRDs. 
		 Create: new CRDs are created, existing CRDs are neither updated nor deleted. 
		 CreateReplace: new CRDs are created, existing CRDs are updated (replaced) but not deleted. 
		 By default, CRDs are applied (installed) during Helm install action. With this option users can opt in to CRD replace existing CRDs on Helm install actions, which is not (yet) natively supported by Helm. https://helm.sh/docs/chart_best_practices/custom_resource_definitions.
		"""

										enum: [
											"Skip",
											"Create",
											"CreateReplace",
										]
										type: "string"
									}
									createNamespace: {
										description: "CreateNamespace tells the Helm install action to create the HelmReleaseSpec.TargetNamespace if it does not exist yet. On uninstall, the namespace will not be garbage collected."

										type: "boolean"
									}
									disableHooks: {
										description: "DisableHooks prevents hooks from running during the Helm install action."

										type: "boolean"
									}
									disableOpenAPIValidation: {
										description: "DisableOpenAPIValidation prevents the Helm install action from validating rendered templates against the Kubernetes OpenAPI Schema."

										type: "boolean"
									}
									disableWait: {
										description: "DisableWait disables the waiting for resources to be ready after a Helm install has been performed."

										type: "boolean"
									}
									disableWaitForJobs: {
										description: "DisableWaitForJobs disables waiting for jobs to complete after a Helm install has been performed."

										type: "boolean"
									}
									remediation: {
										description: "Remediation holds the remediation configuration for when the Helm install action for the HelmRelease fails. The default is to not perform any action."

										properties: {
											ignoreTestFailures: {
												description: "IgnoreTestFailures tells the controller to skip remediation when the Helm tests are run after an install action but fail. Defaults to 'Test.IgnoreFailures'."

												type: "boolean"
											}
											remediateLastFailure: {
												description: "RemediateLastFailure tells the controller to remediate the last failure, when no retries remain. Defaults to 'false'."

												type: "boolean"
											}
											retries: {
												description: "Retries is the number of retries that should be attempted on failures before bailing. Remediation, using an uninstall, is performed between each attempt. Defaults to '0', a negative integer equals to unlimited retries."

												type: "integer"
											}
										}
										type: "object"
									}
									replace: {
										description: "Replace tells the Helm install action to re-use the 'ReleaseName', but only if that name is a deleted release which remains in the history."

										type: "boolean"
									}
									skipCRDs: {
										description: """
		SkipCRDs tells the Helm install action to not install any CRDs. By default, CRDs are installed if not already present. 
		 Deprecated use CRD policy (`crds`) attribute with value `Skip` instead.
		"""

										type: "boolean"
									}
									timeout: {
										description: "Timeout is the time to wait for any individual Kubernetes operation (like Jobs for hooks) during the performance of a Helm install action. Defaults to 'HelmReleaseSpec.Timeout'."

										pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
										type:    "string"
									}
								}
								type: "object"
							}
							interval: {
								description: "Interval at which to reconcile the Helm release."
								pattern:     "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
								type:        "string"
							}
							kubeConfig: {
								description: "KubeConfig for reconciling the HelmRelease on a remote cluster. When used in combination with HelmReleaseSpec.ServiceAccountName, forces the controller to act on behalf of that Service Account at the target cluster. If the --default-service-account flag is set, its value will be used as a controller level fallback for when HelmReleaseSpec.ServiceAccountName is empty."

								properties: secretRef: {
									description: "SecretRef holds the name of a secret that contains a key with the kubeconfig file as the value. If no key is set, the key will default to 'value'. It is recommended that the kubeconfig is self-contained, and the secret is regularly updated if credentials such as a cloud-access-token expire. Cloud specific `cmd-path` auth helpers will not function without adding binaries and credentials to the Pod that is responsible for reconciling Kubernetes resources."

									properties: {
										key: {
											description: "Key in the Secret, when not specified an implementation-specific default key is used."

											type: "string"
										}
										name: {
											description: "Name of the Secret."
											type:        "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								required: ["secretRef"]
								type: "object"
							}
							maxHistory: {
								description: "MaxHistory is the number of revisions saved by Helm for this HelmRelease. Use '0' for an unlimited number of revisions; defaults to '5'."

								type: "integer"
							}
							persistentClient: {
								description: """
		PersistentClient tells the controller to use a persistent Kubernetes client for this release. When enabled, the client will be reused for the duration of the reconciliation, instead of being created and destroyed for each (step of a) Helm action. 
		 This can improve performance, but may cause issues with some Helm charts that for example do create Custom Resource Definitions during installation outside Helm's CRD lifecycle hooks, which are then not observed to be available by e.g. post-install hooks. 
		 If not set, it defaults to true.
		"""

								type: "boolean"
							}
							postRenderers: {
								description: "PostRenderers holds an array of Helm PostRenderers, which will be applied in order of their definition."

								items: {
									description: "PostRenderer contains a Helm PostRenderer specification."
									properties: kustomize: {
										description: "Kustomization to apply as PostRenderer."
										properties: {
											images: {
												description: "Images is a list of (image name, new name, new tag or digest) for changing image names, tags or digests. This can also be achieved with a patch, but this operator is simpler to specify."

												items: {
													description: "Image contains an image name, a new name, a new tag or digest, which will replace the original name and tag."

													properties: {
														digest: {
															description: "Digest is the value used to replace the original image tag. If digest is present NewTag value is ignored."

															type: "string"
														}
														name: {
															description: "Name is a tag-less image name."
															type:        "string"
														}
														newName: {
															description: "NewName is the value used to replace the original name."

															type: "string"
														}
														newTag: {
															description: "NewTag is the value used to replace the original tag."

															type: "string"
														}
													}
													required: ["name"]
													type: "object"
												}
												type: "array"
											}
											patches: {
												description: "Strategic merge and JSON patches, defined as inline YAML objects, capable of targeting objects based on kind, label and annotation selectors."

												items: {
													description: "Patch contains an inline StrategicMerge or JSON6902 patch, and the target the patch should be applied to."

													properties: {
														patch: {
															description: "Patch contains an inline StrategicMerge patch or an inline JSON6902 patch with an array of operation objects."

															type: "string"
														}
														target: {
															description: "Target points to the resources that the patch document should be applied to."

															properties: {
																annotationSelector: {
																	description: "AnnotationSelector is a string that follows the label selection expression https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api It matches with the resource annotations."

																	type: "string"
																}
																group: {
																	description: "Group is the API group to select resources from. Together with Version and Kind it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

																	type: "string"
																}
																kind: {
																	description: "Kind of the API Group to select resources from. Together with Group and Version it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

																	type: "string"
																}
																labelSelector: {
																	description: "LabelSelector is a string that follows the label selection expression https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api It matches with the resource labels."

																	type: "string"
																}
																name: {
																	description: "Name to match resources with."
																	type:        "string"
																}
																namespace: {
																	description: "Namespace to select resources from."
																	type:        "string"
																}
																version: {
																	description: "Version of the API Group to select resources from. Together with Group and Kind it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

																	type: "string"
																}
															}
															type: "object"
														}
													}
													required: ["patch"]
													type: "object"
												}
												type: "array"
											}
											patchesJson6902: {
												description: "JSON 6902 patches, defined as inline YAML objects. Deprecated: use Patches instead."

												items: {
													description: "JSON6902Patch contains a JSON6902 patch and the target the patch should be applied to."

													properties: {
														patch: {
															description: "Patch contains the JSON6902 patch document with an array of operation objects."

															items: {
																description: "JSON6902 is a JSON6902 operation object. https://datatracker.ietf.org/doc/html/rfc6902#section-4"

																properties: {
																	from: {
																		description: "From contains a JSON-pointer value that references a location within the target document where the operation is performed. The meaning of the value depends on the value of Op, and is NOT taken into account by all operations."

																		type: "string"
																	}
																	op: {
																		description: "Op indicates the operation to perform. Its value MUST be one of \"add\", \"remove\", \"replace\", \"move\", \"copy\", or \"test\". https://datatracker.ietf.org/doc/html/rfc6902#section-4"

																		enum: [
																			"test",
																			"remove",
																			"add",
																			"replace",
																			"move",
																			"copy",
																		]
																		type: "string"
																	}
																	path: {
																		description: "Path contains the JSON-pointer value that references a location within the target document where the operation is performed. The meaning of the value depends on the value of Op."

																		type: "string"
																	}
																	value: {
																		description: "Value contains a valid JSON structure. The meaning of the value depends on the value of Op, and is NOT taken into account by all operations."

																		"x-kubernetes-preserve-unknown-fields": true
																	}
																}
																required: [
																	"op",
																	"path",
																]
																type: "object"
															}
															type: "array"
														}
														target: {
															description: "Target points to the resources that the patch document should be applied to."

															properties: {
																annotationSelector: {
																	description: "AnnotationSelector is a string that follows the label selection expression https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api It matches with the resource annotations."

																	type: "string"
																}
																group: {
																	description: "Group is the API group to select resources from. Together with Version and Kind it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

																	type: "string"
																}
																kind: {
																	description: "Kind of the API Group to select resources from. Together with Group and Version it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

																	type: "string"
																}
																labelSelector: {
																	description: "LabelSelector is a string that follows the label selection expression https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api It matches with the resource labels."

																	type: "string"
																}
																name: {
																	description: "Name to match resources with."
																	type:        "string"
																}
																namespace: {
																	description: "Namespace to select resources from."
																	type:        "string"
																}
																version: {
																	description: "Version of the API Group to select resources from. Together with Group and Kind it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

																	type: "string"
																}
															}
															type: "object"
														}
													}
													required: [
														"patch",
														"target",
													]
													type: "object"
												}
												type: "array"
											}
											patchesStrategicMerge: {
												description: "Strategic merge patches, defined as inline YAML objects. Deprecated: use Patches instead."

												items: "x-kubernetes-preserve-unknown-fields": true
												type: "array"
											}
										}
										type: "object"
									}
									type: "object"
								}
								type: "array"
							}
							releaseName: {
								description: "ReleaseName used for the Helm release. Defaults to a composition of '[TargetNamespace-]Name'."

								maxLength: 53
								minLength: 1
								type:      "string"
							}
							rollback: {
								description: "Rollback holds the configuration for Helm rollback actions for this HelmRelease."

								properties: {
									cleanupOnFail: {
										description: "CleanupOnFail allows deletion of new resources created during the Helm rollback action when it fails."

										type: "boolean"
									}
									disableHooks: {
										description: "DisableHooks prevents hooks from running during the Helm rollback action."

										type: "boolean"
									}
									disableWait: {
										description: "DisableWait disables the waiting for resources to be ready after a Helm rollback has been performed."

										type: "boolean"
									}
									disableWaitForJobs: {
										description: "DisableWaitForJobs disables waiting for jobs to complete after a Helm rollback has been performed."

										type: "boolean"
									}
									force: {
										description: "Force forces resource updates through a replacement strategy."

										type: "boolean"
									}
									recreate: {
										description: "Recreate performs pod restarts for the resource if applicable."

										type: "boolean"
									}
									timeout: {
										description: "Timeout is the time to wait for any individual Kubernetes operation (like Jobs for hooks) during the performance of a Helm rollback action. Defaults to 'HelmReleaseSpec.Timeout'."

										pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
										type:    "string"
									}
								}
								type: "object"
							}
							serviceAccountName: {
								description: "The name of the Kubernetes service account to impersonate when reconciling this HelmRelease."

								maxLength: 253
								minLength: 1
								type:      "string"
							}
							storageNamespace: {
								description: "StorageNamespace used for the Helm storage. Defaults to the namespace of the HelmRelease."

								maxLength: 63
								minLength: 1
								type:      "string"
							}
							suspend: {
								description: "Suspend tells the controller to suspend reconciliation for this HelmRelease, it does not apply to already started reconciliations. Defaults to false."

								type: "boolean"
							}
							targetNamespace: {
								description: "TargetNamespace to target when performing operations for the HelmRelease. Defaults to the namespace of the HelmRelease."

								maxLength: 63
								minLength: 1
								type:      "string"
							}
							test: {
								description: "Test holds the configuration for Helm test actions for this HelmRelease."

								properties: {
									enable: {
										description: "Enable enables Helm test actions for this HelmRelease after an Helm install or upgrade action has been performed."

										type: "boolean"
									}
									filters: {
										description: "Filters is a list of tests to run or exclude from running."

										items: {
											description: "Filter holds the configuration for individual Helm test filters."

											properties: {
												exclude: {
													description: "Exclude specifies whether the named test should be excluded."

													type: "boolean"
												}
												name: {
													description: "Name is the name of the test."
													maxLength:   253
													minLength:   1
													type:        "string"
												}
											}
											required: ["name"]
											type: "object"
										}
										type: "array"
									}
									ignoreFailures: {
										description: "IgnoreFailures tells the controller to skip remediation when the Helm tests are run but fail. Can be overwritten for tests run after install or upgrade actions in 'Install.IgnoreTestFailures' and 'Upgrade.IgnoreTestFailures'."

										type: "boolean"
									}
									timeout: {
										description: "Timeout is the time to wait for any individual Kubernetes operation during the performance of a Helm test action. Defaults to 'HelmReleaseSpec.Timeout'."

										pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
										type:    "string"
									}
								}
								type: "object"
							}
							timeout: {
								description: "Timeout is the time to wait for any individual Kubernetes operation (like Jobs for hooks) during the performance of a Helm action. Defaults to '5m0s'."

								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
								type:    "string"
							}
							uninstall: {
								description: "Uninstall holds the configuration for Helm uninstall actions for this HelmRelease."

								properties: {
									deletionPropagation: {
										default:     "background"
										description: "DeletionPropagation specifies the deletion propagation policy when a Helm uninstall is performed."

										enum: [
											"background",
											"foreground",
											"orphan",
										]
										type: "string"
									}
									disableHooks: {
										description: "DisableHooks prevents hooks from running during the Helm rollback action."

										type: "boolean"
									}
									disableWait: {
										description: "DisableWait disables waiting for all the resources to be deleted after a Helm uninstall is performed."

										type: "boolean"
									}
									keepHistory: {
										description: "KeepHistory tells Helm to remove all associated resources and mark the release as deleted, but retain the release history."

										type: "boolean"
									}
									timeout: {
										description: "Timeout is the time to wait for any individual Kubernetes operation (like Jobs for hooks) during the performance of a Helm uninstall action. Defaults to 'HelmReleaseSpec.Timeout'."

										pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
										type:    "string"
									}
								}
								type: "object"
							}
							upgrade: {
								description: "Upgrade holds the configuration for Helm upgrade actions for this HelmRelease."

								properties: {
									cleanupOnFail: {
										description: "CleanupOnFail allows deletion of new resources created during the Helm upgrade action when it fails."

										type: "boolean"
									}
									crds: {
										description: """
		CRDs upgrade CRDs from the Helm Chart's crds directory according to the CRD upgrade policy provided here. Valid values are `Skip`, `Create` or `CreateReplace`. Default is `Skip` and if omitted CRDs are neither installed nor upgraded. 
		 Skip: do neither install nor replace (update) any CRDs. 
		 Create: new CRDs are created, existing CRDs are neither updated nor deleted. 
		 CreateReplace: new CRDs are created, existing CRDs are updated (replaced) but not deleted. 
		 By default, CRDs are not applied during Helm upgrade action. With this option users can opt-in to CRD upgrade, which is not (yet) natively supported by Helm. https://helm.sh/docs/chart_best_practices/custom_resource_definitions.
		"""

										enum: [
											"Skip",
											"Create",
											"CreateReplace",
										]
										type: "string"
									}
									disableHooks: {
										description: "DisableHooks prevents hooks from running during the Helm upgrade action."

										type: "boolean"
									}
									disableOpenAPIValidation: {
										description: "DisableOpenAPIValidation prevents the Helm upgrade action from validating rendered templates against the Kubernetes OpenAPI Schema."

										type: "boolean"
									}
									disableWait: {
										description: "DisableWait disables the waiting for resources to be ready after a Helm upgrade has been performed."

										type: "boolean"
									}
									disableWaitForJobs: {
										description: "DisableWaitForJobs disables waiting for jobs to complete after a Helm upgrade has been performed."

										type: "boolean"
									}
									force: {
										description: "Force forces resource updates through a replacement strategy."

										type: "boolean"
									}
									preserveValues: {
										description: "PreserveValues will make Helm reuse the last release's values and merge in overrides from 'Values'. Setting this flag makes the HelmRelease non-declarative."

										type: "boolean"
									}
									remediation: {
										description: "Remediation holds the remediation configuration for when the Helm upgrade action for the HelmRelease fails. The default is to not perform any action."

										properties: {
											ignoreTestFailures: {
												description: "IgnoreTestFailures tells the controller to skip remediation when the Helm tests are run after an upgrade action but fail. Defaults to 'Test.IgnoreFailures'."

												type: "boolean"
											}
											remediateLastFailure: {
												description: "RemediateLastFailure tells the controller to remediate the last failure, when no retries remain. Defaults to 'false' unless 'Retries' is greater than 0."

												type: "boolean"
											}
											retries: {
												description: "Retries is the number of retries that should be attempted on failures before bailing. Remediation, using 'Strategy', is performed between each attempt. Defaults to '0', a negative integer equals to unlimited retries."

												type: "integer"
											}
											strategy: {
												description: "Strategy to use for failure remediation. Defaults to 'rollback'."

												enum: [
													"rollback",
													"uninstall",
												]
												type: "string"
											}
										}
										type: "object"
									}
									timeout: {
										description: "Timeout is the time to wait for any individual Kubernetes operation (like Jobs for hooks) during the performance of a Helm upgrade action. Defaults to 'HelmReleaseSpec.Timeout'."

										pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
										type:    "string"
									}
								}
								type: "object"
							}
							values: {
								description:                            "Values holds the values for this Helm release."
								"x-kubernetes-preserve-unknown-fields": true
							}
							valuesFrom: {
								description: "ValuesFrom holds references to resources containing Helm values for this HelmRelease, and information about how they should be merged."

								items: {
									description: "ValuesReference contains a reference to a resource containing Helm values, and optionally the key they can be found at."

									properties: {
										kind: {
											description: "Kind of the values referent, valid values are ('Secret', 'ConfigMap')."

											enum: [
												"Secret",
												"ConfigMap",
											]
											type: "string"
										}
										name: {
											description: "Name of the values referent. Should reside in the same namespace as the referring resource."

											maxLength: 253
											minLength: 1
											type:      "string"
										}
										optional: {
											description: "Optional marks this ValuesReference as optional. When set, a not found error for the values reference is ignored, but any ValuesKey, TargetPath or transient error will still result in a reconciliation failure."

											type: "boolean"
										}
										targetPath: {
											description: "TargetPath is the YAML dot notation path the value should be merged at. When set, the ValuesKey is expected to be a single flat value. Defaults to 'None', which results in the values getting merged at the root."

											maxLength: 250
											pattern:   "^([a-zA-Z0-9_\\-.\\\\\\/]|\\[[0-9]{1,5}\\])+$"
											type:      "string"
										}
										valuesKey: {
											description: "ValuesKey is the data key where the values.yaml or a specific value can be found at. Defaults to 'values.yaml'."

											maxLength: 253
											pattern:   "^[\\-._a-zA-Z0-9]+$"
											type:      "string"
										}
									}
									required: [
										"kind",
										"name",
									]
									type: "object"
								}
								type: "array"
							}
						}
						required: [
							"chart",
							"interval",
						]
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "HelmReleaseStatus defines the observed state of a HelmRelease."
						properties: {
							conditions: {
								description: "Conditions holds the conditions for the HelmRelease."
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							failures: {
								description: "Failures is the reconciliation failure count against the latest desired state. It is reset after a successful reconciliation."

								format: "int64"
								type:   "integer"
							}
							helmChart: {
								description: "HelmChart is the namespaced name of the HelmChart resource created by the controller for the HelmRelease."

								type: "string"
							}
							history: {
								description: "History holds the history of Helm releases performed for this HelmRelease up to the last successfully completed release."

								items: {
									description: "Snapshot captures a point-in-time copy of the status information for a Helm release, as managed by the controller."

									properties: {
										apiVersion: {
											description: "APIVersion is the API version of the Snapshot. Provisional: when the calculation method of the Digest field is changed, this field will be used to distinguish between the old and new methods."

											type: "string"
										}
										chartName: {
											description: "ChartName is the chart name of the release object in storage."

											type: "string"
										}
										chartVersion: {
											description: "ChartVersion is the chart version of the release object in storage."

											type: "string"
										}
										configDigest: {
											description: "ConfigDigest is the checksum of the config (better known as \"values\") of the release object in storage. It has the format of `<algo>:<checksum>`."

											type: "string"
										}
										deleted: {
											description: "Deleted is when the release was deleted."
											format:      "date-time"
											type:        "string"
										}
										digest: {
											description: "Digest is the checksum of the release object in storage. It has the format of `<algo>:<checksum>`."

											type: "string"
										}
										firstDeployed: {
											description: "FirstDeployed is when the release was first deployed."
											format:      "date-time"
											type:        "string"
										}
										lastDeployed: {
											description: "LastDeployed is when the release was last deployed."
											format:      "date-time"
											type:        "string"
										}
										name: {
											description: "Name is the name of the release."
											type:        "string"
										}
										namespace: {
											description: "Namespace is the namespace the release is deployed to."

											type: "string"
										}
										status: {
											description: "Status is the current state of the release."
											type:        "string"
										}
										testHooks: {
											additionalProperties: {
												description: "TestHookStatus holds the status information for a test hook as observed to be run by the controller."

												properties: {
													lastCompleted: {
														description: "LastCompleted is the time the test hook last completed."

														format: "date-time"
														type:   "string"
													}
													lastStarted: {
														description: "LastStarted is the time the test hook was last started."

														format: "date-time"
														type:   "string"
													}
													phase: {
														description: "Phase the test hook was observed to be in."
														type:        "string"
													}
												}
												type: "object"
											}
											description: "TestHooks is the list of test hooks for the release as observed to be run by the controller."

											type: "object"
										}
										version: {
											description: "Version is the version of the release object in storage."

											type: "integer"
										}
									}
									required: [
										"chartName",
										"chartVersion",
										"configDigest",
										"digest",
										"firstDeployed",
										"lastDeployed",
										"name",
										"namespace",
										"status",
										"version",
									]
									type: "object"
								}
								type: "array"
							}
							installFailures: {
								description: "InstallFailures is the install failure count against the latest desired state. It is reset after a successful reconciliation."

								format: "int64"
								type:   "integer"
							}
							lastAppliedRevision: {
								description: "LastAppliedRevision is the revision of the last successfully applied source. Deprecated: the revision can now be found in the History."

								type: "string"
							}
							lastAttemptedConfigDigest: {
								description: "LastAttemptedConfigDigest is the digest for the config (better known as \"values\") of the last reconciliation attempt."

								type: "string"
							}
							lastAttemptedGeneration: {
								description: "LastAttemptedGeneration is the last generation the controller attempted to reconcile."

								format: "int64"
								type:   "integer"
							}
							lastAttemptedReleaseAction: {
								description: "LastAttemptedReleaseAction is the last release action performed for this HelmRelease. It is used to determine the active remediation strategy."

								enum: [
									"install",
									"upgrade",
								]
								type: "string"
							}
							lastAttemptedRevision: {
								description: "LastAttemptedRevision is the Source revision of the last reconciliation attempt."

								type: "string"
							}
							lastAttemptedValuesChecksum: {
								description: "LastAttemptedValuesChecksum is the SHA1 checksum for the values of the last reconciliation attempt. Deprecated: Use LastAttemptedConfigDigest instead."

								type: "string"
							}
							lastHandledForceAt: {
								description: "LastHandledForceAt holds the value of the most recent force request value, so a change of the annotation value can be detected."

								type: "string"
							}
							lastHandledReconcileAt: {
								description: "LastHandledReconcileAt holds the value of the most recent reconcile request value, so a change of the annotation value can be detected."

								type: "string"
							}
							lastHandledResetAt: {
								description: "LastHandledResetAt holds the value of the most recent reset request value, so a change of the annotation value can be detected."

								type: "string"
							}
							lastReleaseRevision: {
								description: "LastReleaseRevision is the revision of the last successful Helm release. Deprecated: Use History instead."

								type: "integer"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last observed generation."
								format:      "int64"
								type:        "integer"
							}
							storageNamespace: {
								description: "StorageNamespace is the namespace of the Helm release storage for the current release."

								maxLength: 63
								minLength: 1
								type:      "string"
							}
							upgradeFailures: {
								description: "UpgradeFailures is the upgrade failure count against the latest desired state. It is reset after a successful reconciliation."

								format: "int64"
								type:   "integer"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}
customresourcedefinition: "helmrepositories.source.toolkit.fluxcd.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.12.0"
		name: "helmrepositories.source.toolkit.fluxcd.io"
	}
	spec: {
		group: "source.toolkit.fluxcd.io"
		names: {
			kind:     "HelmRepository"
			listKind: "HelmRepositoryList"
			plural:   "helmrepositories"
			shortNames: ["helmrepo"]
			singular: "helmrepository"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".spec.url"
				name:     "URL"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
				name:     "Ready"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
				name:     "Status"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "HelmRepository is the Schema for the helmrepositories API"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "HelmRepositorySpec defines the reference to a Helm repository."
						properties: {
							accessFrom: {
								description: "AccessFrom defines an Access Control List for allowing cross-namespace references to this object."

								properties: namespaceSelectors: {
									description: "NamespaceSelectors is the list of namespace selectors to which this ACL applies. Items in this list are evaluated using a logical OR operation."

									items: {
										description: "NamespaceSelector selects the namespaces to which this ACL applies. An empty map of MatchLabels matches all namespaces in a cluster."

										properties: matchLabels: {
											additionalProperties: type: "string"
											description: "MatchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."

											type: "object"
										}
										type: "object"
									}
									type: "array"
								}
								required: ["namespaceSelectors"]
								type: "object"
							}
							interval: {
								description: "The interval at which to check the upstream for updates."
								type:        "string"
							}
							passCredentials: {
								description: "PassCredentials allows the credentials from the SecretRef to be passed on to a host that does not match the host as defined in URL. This may be required if the host of the advertised chart URLs in the index differ from the defined URL. Enabling this should be done with caution, as it can potentially result in credentials getting stolen in a MITM-attack."

								type: "boolean"
							}
							secretRef: {
								description: "The name of the secret containing authentication credentials for the Helm repository. For HTTP/S basic auth the secret must contain username and password fields. For TLS the secret must contain a certFile and keyFile, and/or caFile fields."

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							suspend: {
								description: "This flag tells the controller to suspend the reconciliation of this source."

								type: "boolean"
							}
							timeout: {
								default:     "60s"
								description: "The timeout of index downloading, defaults to 60s."
								type:        "string"
							}
							url: {
								description: "The Helm repository URL, a valid URL contains at least a protocol and host."

								type: "string"
							}
						}
						required: [
							"interval",
							"url",
						]
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "HelmRepositoryStatus defines the observed state of the HelmRepository."
						properties: {
							artifact: {
								description: "Artifact represents the output of the last successful repository sync."

								properties: {
									checksum: {
										description: "Checksum is the SHA256 checksum of the artifact."
										type:        "string"
									}
									lastUpdateTime: {
										description: "LastUpdateTime is the timestamp corresponding to the last update of this artifact."

										format: "date-time"
										type:   "string"
									}
									path: {
										description: "Path is the relative file path of this artifact."
										type:        "string"
									}
									revision: {
										description: "Revision is a human readable identifier traceable in the origin source system. It can be a Git commit SHA, Git tag, a Helm index timestamp, a Helm chart version, etc."

										type: "string"
									}
									url: {
										description: "URL is the HTTP address of this artifact."
										type:        "string"
									}
								}
								required: [
									"path",
									"url",
								]
								type: "object"
							}
							conditions: {
								description: "Conditions holds the conditions for the HelmRepository."
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							lastHandledReconcileAt: {
								description: "LastHandledReconcileAt holds the value of the most recent reconcile request value, so a change of the annotation value can be detected."

								type: "string"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last observed generation."
								format:      "int64"
								type:        "integer"
							}
							url: {
								description: "URL is the download link for the last index fetched."
								type:        "string"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: false
			subresources: status: {}
		}, {
			additionalPrinterColumns: [{
				jsonPath: ".spec.url"
				name:     "URL"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
				name:     "Ready"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
				name:     "Status"
				type:     "string"
			}]
			name: "v1beta2"
			schema: openAPIV3Schema: {
				description: "HelmRepository is the Schema for the helmrepositories API."
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "HelmRepositorySpec specifies the required configuration to produce an Artifact for a Helm repository index YAML."

						properties: {
							accessFrom: {
								description: "AccessFrom specifies an Access Control List for allowing cross-namespace references to this object. NOTE: Not implemented, provisional as of https://github.com/fluxcd/flux2/pull/2092"

								properties: namespaceSelectors: {
									description: "NamespaceSelectors is the list of namespace selectors to which this ACL applies. Items in this list are evaluated using a logical OR operation."

									items: {
										description: "NamespaceSelector selects the namespaces to which this ACL applies. An empty map of MatchLabels matches all namespaces in a cluster."

										properties: matchLabels: {
											additionalProperties: type: "string"
											description: "MatchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."

											type: "object"
										}
										type: "object"
									}
									type: "array"
								}
								required: ["namespaceSelectors"]
								type: "object"
							}
							certSecretRef: {
								description: """
		CertSecretRef can be given the name of a Secret containing either or both of 
		 - a PEM-encoded client certificate (`tls.crt`) and private key (`tls.key`); - a PEM-encoded CA certificate (`ca.crt`) 
		 and whichever are supplied, will be used for connecting to the registry. The client cert and key are useful if you are authenticating with a certificate; the CA cert is useful if you are using a self-signed server certificate. The Secret must be of type `Opaque` or `kubernetes.io/tls`. 
		 It takes precedence over the values specified in the Secret referred to by `.spec.secretRef`.
		"""

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							insecure: {
								description: "Insecure allows connecting to a non-TLS HTTP container registry. This field is only taken into account if the .spec.type field is set to 'oci'."

								type: "boolean"
							}
							interval: {
								description: "Interval at which the HelmRepository URL is checked for updates. This interval is approximate and may be subject to jitter to ensure efficient use of resources."

								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
								type:    "string"
							}
							passCredentials: {
								description: "PassCredentials allows the credentials from the SecretRef to be passed on to a host that does not match the host as defined in URL. This may be required if the host of the advertised chart URLs in the index differ from the defined URL. Enabling this should be done with caution, as it can potentially result in credentials getting stolen in a MITM-attack."

								type: "boolean"
							}
							provider: {
								default:     "generic"
								description: "Provider used for authentication, can be 'aws', 'azure', 'gcp' or 'generic'. This field is optional, and only taken into account if the .spec.type field is set to 'oci'. When not specified, defaults to 'generic'."

								enum: [
									"generic",
									"aws",
									"azure",
									"gcp",
								]
								type: "string"
							}
							secretRef: {
								description: "SecretRef specifies the Secret containing authentication credentials for the HelmRepository. For HTTP/S basic auth the secret must contain 'username' and 'password' fields. Support for TLS auth using the 'certFile' and 'keyFile', and/or 'caFile' keys is deprecated. Please use `.spec.certSecretRef` instead."

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							suspend: {
								description: "Suspend tells the controller to suspend the reconciliation of this HelmRepository."

								type: "boolean"
							}
							timeout: {
								description: "Timeout is used for the index fetch operation for an HTTPS helm repository, and for remote OCI Repository operations like pulling for an OCI helm chart by the associated HelmChart. Its default value is 60s."

								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m))+$"
								type:    "string"
							}
							type: {
								description: "Type of the HelmRepository. When this field is set to  \"oci\", the URL field value must be prefixed with \"oci://\"."

								enum: [
									"default",
									"oci",
								]
								type: "string"
							}
							url: {
								description: "URL of the Helm repository, a valid URL contains at least a protocol and host."

								pattern: "^(http|https|oci)://.*$"
								type:    "string"
							}
						}
						required: ["url"]
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "HelmRepositoryStatus records the observed state of the HelmRepository."
						properties: {
							artifact: {
								description: "Artifact represents the last successful HelmRepository reconciliation."

								properties: {
									digest: {
										description: "Digest is the digest of the file in the form of '<algorithm>:<checksum>'."
										pattern:     "^[a-z0-9]+(?:[.+_-][a-z0-9]+)*:[a-zA-Z0-9=_-]+$"
										type:        "string"
									}
									lastUpdateTime: {
										description: "LastUpdateTime is the timestamp corresponding to the last update of the Artifact."

										format: "date-time"
										type:   "string"
									}
									metadata: {
										additionalProperties: type: "string"
										description: "Metadata holds upstream information such as OCI annotations."
										type:        "object"
									}
									path: {
										description: "Path is the relative file path of the Artifact. It can be used to locate the file in the root of the Artifact storage on the local file system of the controller managing the Source."

										type: "string"
									}
									revision: {
										description: "Revision is a human-readable identifier traceable in the origin source system. It can be a Git commit SHA, Git tag, a Helm chart version, etc."

										type: "string"
									}
									size: {
										description: "Size is the number of bytes in the file."
										format:      "int64"
										type:        "integer"
									}
									url: {
										description: "URL is the HTTP address of the Artifact as exposed by the controller managing the Source. It can be used to retrieve the Artifact for consumption, e.g. by another controller applying the Artifact contents."

										type: "string"
									}
								}
								required: [
									"lastUpdateTime",
									"path",
									"revision",
									"url",
								]
								type: "object"
							}
							conditions: {
								description: "Conditions holds the conditions for the HelmRepository."
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							lastHandledReconcileAt: {
								description: "LastHandledReconcileAt holds the value of the most recent reconcile request value, so a change of the annotation value can be detected."

								type: "string"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last observed generation of the HelmRepository object."

								format: "int64"
								type:   "integer"
							}
							url: {
								description: "URL is the dynamic fetch link for the latest Artifact. It is provided on a \"best effort\" basis, and using the precise HelmRepositoryStatus.Artifact data is recommended."

								type: "string"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}
customresourcedefinition: "imagepolicies.image.toolkit.fluxcd.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.12.0"
		name: "imagepolicies.image.toolkit.fluxcd.io"
	}
	spec: {
		group: "image.toolkit.fluxcd.io"
		names: {
			kind:     "ImagePolicy"
			listKind: "ImagePolicyList"
			plural:   "imagepolicies"
			singular: "imagepolicy"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".status.latestImage"
				name:     "LatestImage"
				type:     "string"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "ImagePolicy is the Schema for the imagepolicies API"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "ImagePolicySpec defines the parameters for calculating the ImagePolicy"

						properties: {
							filterTags: {
								description: "FilterTags enables filtering for only a subset of tags based on a set of rules. If no rules are provided, all the tags from the repository will be ordered and compared."

								properties: {
									extract: {
										description: "Extract allows a capture group to be extracted from the specified regular expression pattern, useful before tag evaluation."

										type: "string"
									}
									pattern: {
										description: "Pattern specifies a regular expression pattern used to filter for image tags."

										type: "string"
									}
								}
								type: "object"
							}
							imageRepositoryRef: {
								description: "ImageRepositoryRef points at the object specifying the image being scanned"

								properties: {
									name: {
										description: "Name of the referent."
										type:        "string"
									}
									namespace: {
										description: "Namespace of the referent, when not specified it acts as LocalObjectReference."

										type: "string"
									}
								}
								required: ["name"]
								type: "object"
							}
							policy: {
								description: "Policy gives the particulars of the policy to be followed in selecting the most recent image"

								properties: {
									alphabetical: {
										description: "Alphabetical set of rules to use for alphabetical ordering of the tags."

										properties: order: {
											default:     "asc"
											description: "Order specifies the sorting order of the tags. Given the letters of the alphabet as tags, ascending order would select Z, and descending order would select A."

											enum: [
												"asc",
												"desc",
											]
											type: "string"
										}
										type: "object"
									}
									numerical: {
										description: "Numerical set of rules to use for numerical ordering of the tags."

										properties: order: {
											default:     "asc"
											description: "Order specifies the sorting order of the tags. Given the integer values from 0 to 9 as tags, ascending order would select 9, and descending order would select 0."

											enum: [
												"asc",
												"desc",
											]
											type: "string"
										}
										type: "object"
									}
									semver: {
										description: "SemVer gives a semantic version range to check against the tags available."

										properties: range: {
											description: "Range gives a semver range for the image tag; the highest version within the range that's a tag yields the latest image."

											type: "string"
										}
										required: ["range"]
										type: "object"
									}
								}
								type: "object"
							}
						}
						required: [
							"imageRepositoryRef",
							"policy",
						]
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "ImagePolicyStatus defines the observed state of ImagePolicy"
						properties: {
							conditions: {
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							latestImage: {
								description: "LatestImage gives the first in the list of images scanned by the image repository, when filtered and ordered according to the policy."

								type: "string"
							}
							observedGeneration: {
								format: "int64"
								type:   "integer"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: false
			subresources: status: {}
		}, {
			additionalPrinterColumns: [{
				jsonPath: ".status.latestImage"
				name:     "LatestImage"
				type:     "string"
			}]
			name: "v1beta2"
			schema: openAPIV3Schema: {
				description: "ImagePolicy is the Schema for the imagepolicies API"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "ImagePolicySpec defines the parameters for calculating the ImagePolicy."

						properties: {
							filterTags: {
								description: "FilterTags enables filtering for only a subset of tags based on a set of rules. If no rules are provided, all the tags from the repository will be ordered and compared."

								properties: {
									extract: {
										description: "Extract allows a capture group to be extracted from the specified regular expression pattern, useful before tag evaluation."

										type: "string"
									}
									pattern: {
										description: "Pattern specifies a regular expression pattern used to filter for image tags."

										type: "string"
									}
								}
								type: "object"
							}
							imageRepositoryRef: {
								description: "ImageRepositoryRef points at the object specifying the image being scanned"

								properties: {
									name: {
										description: "Name of the referent."
										type:        "string"
									}
									namespace: {
										description: "Namespace of the referent, when not specified it acts as LocalObjectReference."

										type: "string"
									}
								}
								required: ["name"]
								type: "object"
							}
							policy: {
								description: "Policy gives the particulars of the policy to be followed in selecting the most recent image"

								properties: {
									alphabetical: {
										description: "Alphabetical set of rules to use for alphabetical ordering of the tags."

										properties: order: {
											default:     "asc"
											description: "Order specifies the sorting order of the tags. Given the letters of the alphabet as tags, ascending order would select Z, and descending order would select A."

											enum: [
												"asc",
												"desc",
											]
											type: "string"
										}
										type: "object"
									}
									numerical: {
										description: "Numerical set of rules to use for numerical ordering of the tags."

										properties: order: {
											default:     "asc"
											description: "Order specifies the sorting order of the tags. Given the integer values from 0 to 9 as tags, ascending order would select 9, and descending order would select 0."

											enum: [
												"asc",
												"desc",
											]
											type: "string"
										}
										type: "object"
									}
									semver: {
										description: "SemVer gives a semantic version range to check against the tags available."

										properties: range: {
											description: "Range gives a semver range for the image tag; the highest version within the range that's a tag yields the latest image."

											type: "string"
										}
										required: ["range"]
										type: "object"
									}
								}
								type: "object"
							}
						}
						required: [
							"imageRepositoryRef",
							"policy",
						]
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "ImagePolicyStatus defines the observed state of ImagePolicy"
						properties: {
							conditions: {
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							latestImage: {
								description: "LatestImage gives the first in the list of images scanned by the image repository, when filtered and ordered according to the policy."

								type: "string"
							}
							observedGeneration: {
								format: "int64"
								type:   "integer"
							}
							observedPreviousImage: {
								description: "ObservedPreviousImage is the observed previous LatestImage. It is used to keep track of the previous and current images."

								type: "string"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}
customresourcedefinition: "imagerepositories.image.toolkit.fluxcd.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.12.0"
		name: "imagerepositories.image.toolkit.fluxcd.io"
	}
	spec: {
		group: "image.toolkit.fluxcd.io"
		names: {
			kind:     "ImageRepository"
			listKind: "ImageRepositoryList"
			plural:   "imagerepositories"
			singular: "imagerepository"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".status.lastScanResult.scanTime"
				name:     "Last scan"
				type:     "string"
			}, {
				jsonPath: ".status.lastScanResult.tagCount"
				name:     "Tags"
				type:     "string"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "ImageRepository is the Schema for the imagerepositories API"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "ImageRepositorySpec defines the parameters for scanning an image repository, e.g., `fluxcd/flux`."

						properties: {
							accessFrom: {
								description: "AccessFrom defines an ACL for allowing cross-namespace references to the ImageRepository object based on the caller's namespace labels."

								properties: namespaceSelectors: {
									description: "NamespaceSelectors is the list of namespace selectors to which this ACL applies. Items in this list are evaluated using a logical OR operation."

									items: {
										description: "NamespaceSelector selects the namespaces to which this ACL applies. An empty map of MatchLabels matches all namespaces in a cluster."

										properties: matchLabels: {
											additionalProperties: type: "string"
											description: "MatchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."

											type: "object"
										}
										type: "object"
									}
									type: "array"
								}
								required: ["namespaceSelectors"]
								type: "object"
							}
							certSecretRef: {
								description: """
		CertSecretRef can be given the name of a secret containing either or both of 
		 - a PEM-encoded client certificate (`certFile`) and private key (`keyFile`); - a PEM-encoded CA certificate (`caFile`) 
		 and whichever are supplied, will be used for connecting to the registry. The client cert and key are useful if you are authenticating with a certificate; the CA cert is useful if you are using a self-signed server certificate.
		"""

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							exclusionList: {
								description: "ExclusionList is a list of regex strings used to exclude certain tags from being stored in the database."

								items: type: "string"
								type: "array"
							}
							image: {
								description: "Image is the name of the image repository"
								type:        "string"
							}
							interval: {
								description: "Interval is the length of time to wait between scans of the image repository."

								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
								type:    "string"
							}
							secretRef: {
								description: "SecretRef can be given the name of a secret containing credentials to use for the image registry. The secret should be created with `kubectl create secret docker-registry`, or the equivalent."

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							serviceAccountName: {
								description: "ServiceAccountName is the name of the Kubernetes ServiceAccount used to authenticate the image pull if the service account has attached pull secrets."

								maxLength: 253
								type:      "string"
							}
							suspend: {
								description: "This flag tells the controller to suspend subsequent image scans. It does not apply to already started scans. Defaults to false."

								type: "boolean"
							}
							timeout: {
								description: "Timeout for image scanning. Defaults to 'Interval' duration."
								pattern:     "^([0-9]+(\\.[0-9]+)?(ms|s|m))+$"
								type:        "string"
							}
						}
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "ImageRepositoryStatus defines the observed state of ImageRepository"
						properties: {
							canonicalImageName: {
								description: "CanonicalName is the name of the image repository with all the implied bits made explicit; e.g., `docker.io/library/alpine` rather than `alpine`."

								type: "string"
							}
							conditions: {
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							lastHandledReconcileAt: {
								description: "LastHandledReconcileAt holds the value of the most recent reconcile request value, so a change of the annotation value can be detected."

								type: "string"
							}
							lastScanResult: {
								description: "LastScanResult contains the number of fetched tags."
								properties: {
									scanTime: {
										format: "date-time"
										type:   "string"
									}
									tagCount: type: "integer"
								}
								required: ["tagCount"]
								type: "object"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last reconciled generation."
								format:      "int64"
								type:        "integer"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: false
			subresources: status: {}
		}, {
			additionalPrinterColumns: [{
				jsonPath: ".status.lastScanResult.scanTime"
				name:     "Last scan"
				type:     "string"
			}, {
				jsonPath: ".status.lastScanResult.tagCount"
				name:     "Tags"
				type:     "string"
			}]
			name: "v1beta2"
			schema: openAPIV3Schema: {
				description: "ImageRepository is the Schema for the imagerepositories API"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "ImageRepositorySpec defines the parameters for scanning an image repository, e.g., `fluxcd/flux`."

						properties: {
							accessFrom: {
								description: "AccessFrom defines an ACL for allowing cross-namespace references to the ImageRepository object based on the caller's namespace labels."

								properties: namespaceSelectors: {
									description: "NamespaceSelectors is the list of namespace selectors to which this ACL applies. Items in this list are evaluated using a logical OR operation."

									items: {
										description: "NamespaceSelector selects the namespaces to which this ACL applies. An empty map of MatchLabels matches all namespaces in a cluster."

										properties: matchLabels: {
											additionalProperties: type: "string"
											description: "MatchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."

											type: "object"
										}
										type: "object"
									}
									type: "array"
								}
								required: ["namespaceSelectors"]
								type: "object"
							}
							certSecretRef: {
								description: """
		CertSecretRef can be given the name of a Secret containing either or both of 
		 - a PEM-encoded client certificate (`tls.crt`) and private key (`tls.key`); - a PEM-encoded CA certificate (`ca.crt`) 
		 and whichever are supplied, will be used for connecting to the registry. The client cert and key are useful if you are authenticating with a certificate; the CA cert is useful if you are using a self-signed server certificate. The Secret must be of type `Opaque` or `kubernetes.io/tls`. 
		 Note: Support for the `caFile`, `certFile` and `keyFile` keys has been deprecated.
		"""

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							exclusionList: {
								default: ["^.*\\.sig$"]
								description: "ExclusionList is a list of regex strings used to exclude certain tags from being stored in the database."

								items: type: "string"
								maxItems: 25
								type:     "array"
							}
							image: {
								description: "Image is the name of the image repository"
								type:        "string"
							}
							insecure: {
								description: "Insecure allows connecting to a non-TLS HTTP container registry."

								type: "boolean"
							}
							interval: {
								description: "Interval is the length of time to wait between scans of the image repository."

								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
								type:    "string"
							}
							provider: {
								default:     "generic"
								description: "The provider used for authentication, can be 'aws', 'azure', 'gcp' or 'generic'. When not specified, defaults to 'generic'."

								enum: [
									"generic",
									"aws",
									"azure",
									"gcp",
								]
								type: "string"
							}
							secretRef: {
								description: "SecretRef can be given the name of a secret containing credentials to use for the image registry. The secret should be created with `kubectl create secret docker-registry`, or the equivalent."

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							serviceAccountName: {
								description: "ServiceAccountName is the name of the Kubernetes ServiceAccount used to authenticate the image pull if the service account has attached pull secrets."

								maxLength: 253
								type:      "string"
							}
							suspend: {
								description: "This flag tells the controller to suspend subsequent image scans. It does not apply to already started scans. Defaults to false."

								type: "boolean"
							}
							timeout: {
								description: "Timeout for image scanning. Defaults to 'Interval' duration."
								pattern:     "^([0-9]+(\\.[0-9]+)?(ms|s|m))+$"
								type:        "string"
							}
						}
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "ImageRepositoryStatus defines the observed state of ImageRepository"
						properties: {
							canonicalImageName: {
								description: "CanonicalName is the name of the image repository with all the implied bits made explicit; e.g., `docker.io/library/alpine` rather than `alpine`."

								type: "string"
							}
							conditions: {
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							lastHandledReconcileAt: {
								description: "LastHandledReconcileAt holds the value of the most recent reconcile request value, so a change of the annotation value can be detected."

								type: "string"
							}
							lastScanResult: {
								description: "LastScanResult contains the number of fetched tags."
								properties: {
									latestTags: {
										items: type: "string"
										type: "array"
									}
									scanTime: {
										format: "date-time"
										type:   "string"
									}
									tagCount: type: "integer"
								}
								required: ["tagCount"]
								type: "object"
							}
							observedExclusionList: {
								description: "ObservedExclusionList is a list of observed exclusion list. It reflects the exclusion rules used for the observed scan result in spec.lastScanResult."

								items: type: "string"
								type: "array"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last reconciled generation."
								format:      "int64"
								type:        "integer"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}
customresourcedefinition: "imageupdateautomations.image.toolkit.fluxcd.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.12.0"
		name: "imageupdateautomations.image.toolkit.fluxcd.io"
	}
	spec: {
		group: "image.toolkit.fluxcd.io"
		names: {
			kind:     "ImageUpdateAutomation"
			listKind: "ImageUpdateAutomationList"
			plural:   "imageupdateautomations"
			singular: "imageupdateautomation"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".status.lastAutomationRunTime"
				name:     "Last run"
				type:     "string"
			}]
			name: "v1beta1"
			schema: openAPIV3Schema: {
				description: "ImageUpdateAutomation is the Schema for the imageupdateautomations API"

				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "ImageUpdateAutomationSpec defines the desired state of ImageUpdateAutomation"
						properties: {
							git: {
								description: "GitSpec contains all the git-specific definitions. This is technically optional, but in practice mandatory until there are other kinds of source allowed."

								properties: {
									checkout: {
										description: "Checkout gives the parameters for cloning the git repository, ready to make changes. If not present, the `spec.ref` field from the referenced `GitRepository` or its default will be used."

										properties: ref: {
											description: "Reference gives a branch, tag or commit to clone from the Git repository."

											properties: {
												branch: {
													description: "Branch to check out, defaults to 'master' if no other field is defined."

													type: "string"
												}
												commit: {
													description: """
		Commit SHA to check out, takes precedence over all reference fields. 
		 This can be combined with Branch to shallow clone the branch, in which the commit is expected to exist.
		"""

													type: "string"
												}
												name: {
													description: """
		Name of the reference to check out; takes precedence over Branch, Tag and SemVer. 
		 It must be a valid Git reference: https://git-scm.com/docs/git-check-ref-format#_description Examples: \"refs/heads/main\", \"refs/tags/v0.1.0\", \"refs/pull/420/head\", \"refs/merge-requests/1/head\"
		"""

													type: "string"
												}
												semver: {
													description: "SemVer tag expression to check out, takes precedence over Tag."

													type: "string"
												}
												tag: {
													description: "Tag to check out, takes precedence over Branch."
													type:        "string"
												}
											}
											type: "object"
										}
										required: ["ref"]
										type: "object"
									}
									commit: {
										description: "Commit specifies how to commit to the git repository."
										properties: {
											author: {
												description: "Author gives the email and optionally the name to use as the author of commits."

												properties: {
													email: {
														description: "Email gives the email to provide when making a commit."

														type: "string"
													}
													name: {
														description: "Name gives the name to provide when making a commit."

														type: "string"
													}
												}
												required: ["email"]
												type: "object"
											}
											messageTemplate: {
												description: "MessageTemplate provides a template for the commit message, into which will be interpolated the details of the change made."

												type: "string"
											}
											signingKey: {
												description: "SigningKey provides the option to sign commits with a GPG key"

												properties: secretRef: {
													description: "SecretRef holds the name to a secret that contains a 'git.asc' key corresponding to the ASCII Armored file containing the GPG signing keypair as the value. It must be in the same namespace as the ImageUpdateAutomation."

													properties: name: {
														description: "Name of the referent."
														type:        "string"
													}
													required: ["name"]
													type: "object"
												}
												type: "object"
											}
										}
										required: ["author"]
										type: "object"
									}
									push: {
										description: "Push specifies how and where to push commits made by the automation. If missing, commits are pushed (back) to `.spec.checkout.branch` or its default."

										properties: {
											branch: {
												description: "Branch specifies that commits should be pushed to the branch named. The branch is created using `.spec.checkout.branch` as the starting point, if it doesn't already exist."

												type: "string"
											}
											options: {
												additionalProperties: type: "string"
												description: "Options specifies the push options that are sent to the Git server when performing a push operation. For details, see: https://git-scm.com/docs/git-push#Documentation/git-push.txt---push-optionltoptiongt"

												type: "object"
											}
											refspec: {
												description: "Refspec specifies the Git Refspec to use for a push operation. If both Branch and Refspec are provided, then the commit is pushed to the branch and also using the specified refspec. For more details about Git Refspecs, see: https://git-scm.com/book/en/v2/Git-Internals-The-Refspec"

												type: "string"
											}
										}
										type: "object"
									}
								}
								required: ["commit"]
								type: "object"
							}
							interval: {
								description: "Interval gives an lower bound for how often the automation run should be attempted."

								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
								type:    "string"
							}
							sourceRef: {
								description: "SourceRef refers to the resource giving access details to a git repository."

								properties: {
									apiVersion: {
										description: "API version of the referent."
										type:        "string"
									}
									kind: {
										default:     "GitRepository"
										description: "Kind of the referent."
										enum: ["GitRepository"]
										type: "string"
									}
									name: {
										description: "Name of the referent."
										type:        "string"
									}
									namespace: {
										description: "Namespace of the referent, defaults to the namespace of the Kubernetes resource object that contains the reference."

										type: "string"
									}
								}
								required: [
									"kind",
									"name",
								]
								type: "object"
							}
							suspend: {
								description: "Suspend tells the controller to not run this automation, until it is unset (or set to false). Defaults to false."

								type: "boolean"
							}
							update: {
								default: strategy: "Setters"
								description: "Update gives the specification for how to update the files in the repository. This can be left empty, to use the default value."

								properties: {
									path: {
										description: "Path to the directory containing the manifests to be updated. Defaults to 'None', which translates to the root path of the GitRepositoryRef."

										type: "string"
									}
									strategy: {
										default:     "Setters"
										description: "Strategy names the strategy to be used."
										enum: ["Setters"]
										type: "string"
									}
								}
								required: ["strategy"]
								type: "object"
							}
						}
						required: [
							"interval",
							"sourceRef",
						]
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "ImageUpdateAutomationStatus defines the observed state of ImageUpdateAutomation"

						properties: {
							conditions: {
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							lastAutomationRunTime: {
								description: "LastAutomationRunTime records the last time the controller ran this automation through to completion (even if no updates were made)."

								format: "date-time"
								type:   "string"
							}
							lastHandledReconcileAt: {
								description: "LastHandledReconcileAt holds the value of the most recent reconcile request value, so a change of the annotation value can be detected."

								type: "string"
							}
							lastPushCommit: {
								description: "LastPushCommit records the SHA1 of the last commit made by the controller, for this automation object"

								type: "string"
							}
							lastPushTime: {
								description: "LastPushTime records the time of the last pushed change."
								format:      "date-time"
								type:        "string"
							}
							observedGeneration: {
								format: "int64"
								type:   "integer"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}
customresourcedefinition: "kustomizations.kustomize.toolkit.fluxcd.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.12.0"
		name: "kustomizations.kustomize.toolkit.fluxcd.io"
	}
	spec: {
		group: "kustomize.toolkit.fluxcd.io"
		names: {
			kind:     "Kustomization"
			listKind: "KustomizationList"
			plural:   "kustomizations"
			shortNames: ["ks"]
			singular: "kustomization"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
				name:     "Ready"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
				name:     "Status"
				type:     "string"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				description: "Kustomization is the Schema for the kustomizations API."
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "KustomizationSpec defines the configuration to calculate the desired state from a Source using Kustomize."

						properties: {
							commonMetadata: {
								description: "CommonMetadata specifies the common labels and annotations that are applied to all resources. Any existing label or annotation will be overridden if its key matches a common one."

								properties: {
									annotations: {
										additionalProperties: type: "string"
										description: "Annotations to be added to the object's metadata."
										type:        "object"
									}
									labels: {
										additionalProperties: type: "string"
										description: "Labels to be added to the object's metadata."
										type:        "object"
									}
								}
								type: "object"
							}
							components: {
								description: "Components specifies relative paths to specifications of other Components."

								items: type: "string"
								type: "array"
							}
							decryption: {
								description: "Decrypt Kubernetes secrets before applying them on the cluster."

								properties: {
									provider: {
										description: "Provider is the name of the decryption engine."
										enum: ["sops"]
										type: "string"
									}
									secretRef: {
										description: "The secret name containing the private OpenPGP keys used for decryption."

										properties: name: {
											description: "Name of the referent."
											type:        "string"
										}
										required: ["name"]
										type: "object"
									}
								}
								required: ["provider"]
								type: "object"
							}
							dependsOn: {
								description: "DependsOn may contain a meta.NamespacedObjectReference slice with references to Kustomization resources that must be ready before this Kustomization can be reconciled."

								items: {
									description: "NamespacedObjectReference contains enough information to locate the referenced Kubernetes resource object in any namespace."

									properties: {
										name: {
											description: "Name of the referent."
											type:        "string"
										}
										namespace: {
											description: "Namespace of the referent, when not specified it acts as LocalObjectReference."

											type: "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								type: "array"
							}
							force: {
								default:     false
								description: "Force instructs the controller to recreate resources when patching fails due to an immutable field change."

								type: "boolean"
							}
							healthChecks: {
								description: "A list of resources to be included in the health assessment."
								items: {
									description: "NamespacedObjectKindReference contains enough information to locate the typed referenced Kubernetes resource object in any namespace."

									properties: {
										apiVersion: {
											description: "API version of the referent, if not specified the Kubernetes preferred version will be used."

											type: "string"
										}
										kind: {
											description: "Kind of the referent."
											type:        "string"
										}
										name: {
											description: "Name of the referent."
											type:        "string"
										}
										namespace: {
											description: "Namespace of the referent, when not specified it acts as LocalObjectReference."

											type: "string"
										}
									}
									required: [
										"kind",
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							images: {
								description: "Images is a list of (image name, new name, new tag or digest) for changing image names, tags or digests. This can also be achieved with a patch, but this operator is simpler to specify."

								items: {
									description: "Image contains an image name, a new name, a new tag or digest, which will replace the original name and tag."

									properties: {
										digest: {
											description: "Digest is the value used to replace the original image tag. If digest is present NewTag value is ignored."

											type: "string"
										}
										name: {
											description: "Name is a tag-less image name."
											type:        "string"
										}
										newName: {
											description: "NewName is the value used to replace the original name."

											type: "string"
										}
										newTag: {
											description: "NewTag is the value used to replace the original tag."

											type: "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								type: "array"
							}
							interval: {
								description: "The interval at which to reconcile the Kustomization. This interval is approximate and may be subject to jitter to ensure efficient use of resources."

								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
								type:    "string"
							}
							kubeConfig: {
								description: "The KubeConfig for reconciling the Kustomization on a remote cluster. When used in combination with KustomizationSpec.ServiceAccountName, forces the controller to act on behalf of that Service Account at the target cluster. If the --default-service-account flag is set, its value will be used as a controller level fallback for when KustomizationSpec.ServiceAccountName is empty."

								properties: secretRef: {
									description: "SecretRef holds the name of a secret that contains a key with the kubeconfig file as the value. If no key is set, the key will default to 'value'. It is recommended that the kubeconfig is self-contained, and the secret is regularly updated if credentials such as a cloud-access-token expire. Cloud specific `cmd-path` auth helpers will not function without adding binaries and credentials to the Pod that is responsible for reconciling Kubernetes resources."

									properties: {
										key: {
											description: "Key in the Secret, when not specified an implementation-specific default key is used."

											type: "string"
										}
										name: {
											description: "Name of the Secret."
											type:        "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								required: ["secretRef"]
								type: "object"
							}
							patches: {
								description: "Strategic merge and JSON patches, defined as inline YAML objects, capable of targeting objects based on kind, label and annotation selectors."

								items: {
									description: "Patch contains an inline StrategicMerge or JSON6902 patch, and the target the patch should be applied to."

									properties: {
										patch: {
											description: "Patch contains an inline StrategicMerge patch or an inline JSON6902 patch with an array of operation objects."

											type: "string"
										}
										target: {
											description: "Target points to the resources that the patch document should be applied to."

											properties: {
												annotationSelector: {
													description: "AnnotationSelector is a string that follows the label selection expression https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api It matches with the resource annotations."

													type: "string"
												}
												group: {
													description: "Group is the API group to select resources from. Together with Version and Kind it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

													type: "string"
												}
												kind: {
													description: "Kind of the API Group to select resources from. Together with Group and Version it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

													type: "string"
												}
												labelSelector: {
													description: "LabelSelector is a string that follows the label selection expression https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api It matches with the resource labels."

													type: "string"
												}
												name: {
													description: "Name to match resources with."
													type:        "string"
												}
												namespace: {
													description: "Namespace to select resources from."
													type:        "string"
												}
												version: {
													description: "Version of the API Group to select resources from. Together with Group and Kind it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

													type: "string"
												}
											}
											type: "object"
										}
									}
									required: ["patch"]
									type: "object"
								}
								type: "array"
							}
							path: {
								description: "Path to the directory containing the kustomization.yaml file, or the set of plain YAMLs a kustomization.yaml should be generated for. Defaults to 'None', which translates to the root path of the SourceRef."

								type: "string"
							}
							postBuild: {
								description: "PostBuild describes which actions to perform on the YAML manifest generated by building the kustomize overlay."

								properties: {
									substitute: {
										additionalProperties: type: "string"
										description: "Substitute holds a map of key/value pairs. The variables defined in your YAML manifests that match any of the keys defined in the map will be substituted with the set value. Includes support for bash string replacement functions e.g. ${var:=default}, ${var:position} and ${var/substring/replacement}."

										type: "object"
									}
									substituteFrom: {
										description: "SubstituteFrom holds references to ConfigMaps and Secrets containing the variables and their values to be substituted in the YAML manifests. The ConfigMap and the Secret data keys represent the var names, and they must match the vars declared in the manifests for the substitution to happen."

										items: {
											description: "SubstituteReference contains a reference to a resource containing the variables name and value."

											properties: {
												kind: {
													description: "Kind of the values referent, valid values are ('Secret', 'ConfigMap')."

													enum: [
														"Secret",
														"ConfigMap",
													]
													type: "string"
												}
												name: {
													description: "Name of the values referent. Should reside in the same namespace as the referring resource."

													maxLength: 253
													minLength: 1
													type:      "string"
												}
												optional: {
													default:     false
													description: "Optional indicates whether the referenced resource must exist, or whether to tolerate its absence. If true and the referenced resource is absent, proceed as if the resource was present but empty, without any variables defined."

													type: "boolean"
												}
											}
											required: [
												"kind",
												"name",
											]
											type: "object"
										}
										type: "array"
									}
								}
								type: "object"
							}
							prune: {
								description: "Prune enables garbage collection."
								type:        "boolean"
							}
							retryInterval: {
								description: "The interval at which to retry a previously failed reconciliation. When not specified, the controller uses the KustomizationSpec.Interval value to retry failures."

								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
								type:    "string"
							}
							serviceAccountName: {
								description: "The name of the Kubernetes service account to impersonate when reconciling this Kustomization."

								type: "string"
							}
							sourceRef: {
								description: "Reference of the source where the kustomization file is."

								properties: {
									apiVersion: {
										description: "API version of the referent."
										type:        "string"
									}
									kind: {
										description: "Kind of the referent."
										enum: [
											"OCIRepository",
											"GitRepository",
											"Bucket",
										]
										type: "string"
									}
									name: {
										description: "Name of the referent."
										type:        "string"
									}
									namespace: {
										description: "Namespace of the referent, defaults to the namespace of the Kubernetes resource object that contains the reference."

										type: "string"
									}
								}
								required: [
									"kind",
									"name",
								]
								type: "object"
							}
							suspend: {
								description: "This flag tells the controller to suspend subsequent kustomize executions, it does not apply to already started executions. Defaults to false."

								type: "boolean"
							}
							targetNamespace: {
								description: "TargetNamespace sets or overrides the namespace in the kustomization.yaml file."

								maxLength: 63
								minLength: 1
								type:      "string"
							}
							timeout: {
								description: "Timeout for validation, apply and health checking operations. Defaults to 'Interval' duration."

								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
								type:    "string"
							}
							wait: {
								description: "Wait instructs the controller to check the health of all the reconciled resources. When enabled, the HealthChecks are ignored. Defaults to false."

								type: "boolean"
							}
						}
						required: [
							"interval",
							"prune",
							"sourceRef",
						]
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "KustomizationStatus defines the observed state of a kustomization."
						properties: {
							conditions: {
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							inventory: {
								description: "Inventory contains the list of Kubernetes resource object references that have been successfully applied."

								properties: entries: {
									description: "Entries of Kubernetes resource object references."
									items: {
										description: "ResourceRef contains the information necessary to locate a resource within a cluster."

										properties: {
											id: {
												description: "ID is the string representation of the Kubernetes resource object's metadata, in the format '<namespace>_<name>_<group>_<kind>'."

												type: "string"
											}
											v: {
												description: "Version is the API version of the Kubernetes resource object's kind."

												type: "string"
											}
										}
										required: [
											"id",
											"v",
										]
										type: "object"
									}
									type: "array"
								}
								required: ["entries"]
								type: "object"
							}
							lastAppliedRevision: {
								description: "The last successfully applied revision. Equals the Revision of the applied Artifact from the referenced Source."

								type: "string"
							}
							lastAttemptedRevision: {
								description: "LastAttemptedRevision is the revision of the last reconciliation attempt."

								type: "string"
							}
							lastHandledReconcileAt: {
								description: "LastHandledReconcileAt holds the value of the most recent reconcile request value, so a change of the annotation value can be detected."

								type: "string"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last reconciled generation."
								format:      "int64"
								type:        "integer"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}, {
			additionalPrinterColumns: [{
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
				name:     "Ready"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
				name:     "Status"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			deprecated:         true
			deprecationWarning: "v1beta1 Kustomization is deprecated, upgrade to v1"
			name:               "v1beta1"
			schema: openAPIV3Schema: {
				description: "Kustomization is the Schema for the kustomizations API."
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "KustomizationSpec defines the desired state of a kustomization."
						properties: {
							decryption: {
								description: "Decrypt Kubernetes secrets before applying them on the cluster."

								properties: {
									provider: {
										description: "Provider is the name of the decryption engine."
										enum: ["sops"]
										type: "string"
									}
									secretRef: {
										description: "The secret name containing the private OpenPGP keys used for decryption."

										properties: name: {
											description: "Name of the referent."
											type:        "string"
										}
										required: ["name"]
										type: "object"
									}
								}
								required: ["provider"]
								type: "object"
							}
							dependsOn: {
								description: "DependsOn may contain a meta.NamespacedObjectReference slice with references to Kustomization resources that must be ready before this Kustomization can be reconciled."

								items: {
									description: "NamespacedObjectReference contains enough information to locate the referenced Kubernetes resource object in any namespace."

									properties: {
										name: {
											description: "Name of the referent."
											type:        "string"
										}
										namespace: {
											description: "Namespace of the referent, when not specified it acts as LocalObjectReference."

											type: "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								type: "array"
							}
							force: {
								default:     false
								description: "Force instructs the controller to recreate resources when patching fails due to an immutable field change."

								type: "boolean"
							}
							healthChecks: {
								description: "A list of resources to be included in the health assessment."
								items: {
									description: "NamespacedObjectKindReference contains enough information to locate the typed referenced Kubernetes resource object in any namespace."

									properties: {
										apiVersion: {
											description: "API version of the referent, if not specified the Kubernetes preferred version will be used."

											type: "string"
										}
										kind: {
											description: "Kind of the referent."
											type:        "string"
										}
										name: {
											description: "Name of the referent."
											type:        "string"
										}
										namespace: {
											description: "Namespace of the referent, when not specified it acts as LocalObjectReference."

											type: "string"
										}
									}
									required: [
										"kind",
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							images: {
								description: "Images is a list of (image name, new name, new tag or digest) for changing image names, tags or digests. This can also be achieved with a patch, but this operator is simpler to specify."

								items: {
									description: "Image contains an image name, a new name, a new tag or digest, which will replace the original name and tag."

									properties: {
										digest: {
											description: "Digest is the value used to replace the original image tag. If digest is present NewTag value is ignored."

											type: "string"
										}
										name: {
											description: "Name is a tag-less image name."
											type:        "string"
										}
										newName: {
											description: "NewName is the value used to replace the original name."

											type: "string"
										}
										newTag: {
											description: "NewTag is the value used to replace the original tag."

											type: "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								type: "array"
							}
							interval: {
								description: "The interval at which to reconcile the Kustomization."
								type:        "string"
							}
							kubeConfig: {
								description: "The KubeConfig for reconciling the Kustomization on a remote cluster. When specified, KubeConfig takes precedence over ServiceAccountName."

								properties: secretRef: {
									description: "SecretRef holds the name to a secret that contains a 'value' key with the kubeconfig file as the value. It must be in the same namespace as the Kustomization. It is recommended that the kubeconfig is self-contained, and the secret is regularly updated if credentials such as a cloud-access-token expire. Cloud specific `cmd-path` auth helpers will not function without adding binaries and credentials to the Pod that is responsible for reconciling the Kustomization."

									properties: name: {
										description: "Name of the referent."
										type:        "string"
									}
									required: ["name"]
									type: "object"
								}
								type: "object"
							}
							patches: {
								description: "Strategic merge and JSON patches, defined as inline YAML objects, capable of targeting objects based on kind, label and annotation selectors."

								items: {
									description: "Patch contains an inline StrategicMerge or JSON6902 patch, and the target the patch should be applied to."

									properties: {
										patch: {
											description: "Patch contains an inline StrategicMerge patch or an inline JSON6902 patch with an array of operation objects."

											type: "string"
										}
										target: {
											description: "Target points to the resources that the patch document should be applied to."

											properties: {
												annotationSelector: {
													description: "AnnotationSelector is a string that follows the label selection expression https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api It matches with the resource annotations."

													type: "string"
												}
												group: {
													description: "Group is the API group to select resources from. Together with Version and Kind it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

													type: "string"
												}
												kind: {
													description: "Kind of the API Group to select resources from. Together with Group and Version it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

													type: "string"
												}
												labelSelector: {
													description: "LabelSelector is a string that follows the label selection expression https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api It matches with the resource labels."

													type: "string"
												}
												name: {
													description: "Name to match resources with."
													type:        "string"
												}
												namespace: {
													description: "Namespace to select resources from."
													type:        "string"
												}
												version: {
													description: "Version of the API Group to select resources from. Together with Group and Kind it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

													type: "string"
												}
											}
											type: "object"
										}
									}
									required: ["patch"]
									type: "object"
								}
								type: "array"
							}
							patchesJson6902: {
								description: "JSON 6902 patches, defined as inline YAML objects."
								items: {
									description: "JSON6902Patch contains a JSON6902 patch and the target the patch should be applied to."

									properties: {
										patch: {
											description: "Patch contains the JSON6902 patch document with an array of operation objects."

											items: {
												description: "JSON6902 is a JSON6902 operation object. https://datatracker.ietf.org/doc/html/rfc6902#section-4"
												properties: {
													from: {
														description: "From contains a JSON-pointer value that references a location within the target document where the operation is performed. The meaning of the value depends on the value of Op, and is NOT taken into account by all operations."

														type: "string"
													}
													op: {
														description: "Op indicates the operation to perform. Its value MUST be one of \"add\", \"remove\", \"replace\", \"move\", \"copy\", or \"test\". https://datatracker.ietf.org/doc/html/rfc6902#section-4"

														enum: [
															"test",
															"remove",
															"add",
															"replace",
															"move",
															"copy",
														]
														type: "string"
													}
													path: {
														description: "Path contains the JSON-pointer value that references a location within the target document where the operation is performed. The meaning of the value depends on the value of Op."

														type: "string"
													}
													value: {
														description: "Value contains a valid JSON structure. The meaning of the value depends on the value of Op, and is NOT taken into account by all operations."

														"x-kubernetes-preserve-unknown-fields": true
													}
												}
												required: [
													"op",
													"path",
												]
												type: "object"
											}
											type: "array"
										}
										target: {
											description: "Target points to the resources that the patch document should be applied to."

											properties: {
												annotationSelector: {
													description: "AnnotationSelector is a string that follows the label selection expression https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api It matches with the resource annotations."

													type: "string"
												}
												group: {
													description: "Group is the API group to select resources from. Together with Version and Kind it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

													type: "string"
												}
												kind: {
													description: "Kind of the API Group to select resources from. Together with Group and Version it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

													type: "string"
												}
												labelSelector: {
													description: "LabelSelector is a string that follows the label selection expression https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api It matches with the resource labels."

													type: "string"
												}
												name: {
													description: "Name to match resources with."
													type:        "string"
												}
												namespace: {
													description: "Namespace to select resources from."
													type:        "string"
												}
												version: {
													description: "Version of the API Group to select resources from. Together with Group and Kind it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

													type: "string"
												}
											}
											type: "object"
										}
									}
									required: [
										"patch",
										"target",
									]
									type: "object"
								}
								type: "array"
							}
							patchesStrategicMerge: {
								description: "Strategic merge patches, defined as inline YAML objects."
								items: "x-kubernetes-preserve-unknown-fields": true
								type: "array"
							}
							path: {
								description: "Path to the directory containing the kustomization.yaml file, or the set of plain YAMLs a kustomization.yaml should be generated for. Defaults to 'None', which translates to the root path of the SourceRef."

								type: "string"
							}
							postBuild: {
								description: "PostBuild describes which actions to perform on the YAML manifest generated by building the kustomize overlay."

								properties: {
									substitute: {
										additionalProperties: type: "string"
										description: "Substitute holds a map of key/value pairs. The variables defined in your YAML manifests that match any of the keys defined in the map will be substituted with the set value. Includes support for bash string replacement functions e.g. ${var:=default}, ${var:position} and ${var/substring/replacement}."

										type: "object"
									}
									substituteFrom: {
										description: "SubstituteFrom holds references to ConfigMaps and Secrets containing the variables and their values to be substituted in the YAML manifests. The ConfigMap and the Secret data keys represent the var names and they must match the vars declared in the manifests for the substitution to happen."

										items: {
											description: "SubstituteReference contains a reference to a resource containing the variables name and value."

											properties: {
												kind: {
													description: "Kind of the values referent, valid values are ('Secret', 'ConfigMap')."

													enum: [
														"Secret",
														"ConfigMap",
													]
													type: "string"
												}
												name: {
													description: "Name of the values referent. Should reside in the same namespace as the referring resource."

													maxLength: 253
													minLength: 1
													type:      "string"
												}
											}
											required: [
												"kind",
												"name",
											]
											type: "object"
										}
										type: "array"
									}
								}
								type: "object"
							}
							prune: {
								description: "Prune enables garbage collection."
								type:        "boolean"
							}
							retryInterval: {
								description: "The interval at which to retry a previously failed reconciliation. When not specified, the controller uses the KustomizationSpec.Interval value to retry failures."

								type: "string"
							}
							serviceAccountName: {
								description: "The name of the Kubernetes service account to impersonate when reconciling this Kustomization."

								type: "string"
							}
							sourceRef: {
								description: "Reference of the source where the kustomization file is."

								properties: {
									apiVersion: {
										description: "API version of the referent"
										type:        "string"
									}
									kind: {
										description: "Kind of the referent"
										enum: [
											"GitRepository",
											"Bucket",
										]
										type: "string"
									}
									name: {
										description: "Name of the referent"
										type:        "string"
									}
									namespace: {
										description: "Namespace of the referent, defaults to the Kustomization namespace"

										type: "string"
									}
								}
								required: [
									"kind",
									"name",
								]
								type: "object"
							}
							suspend: {
								description: "This flag tells the controller to suspend subsequent kustomize executions, it does not apply to already started executions. Defaults to false."

								type: "boolean"
							}
							targetNamespace: {
								description: "TargetNamespace sets or overrides the namespace in the kustomization.yaml file."

								maxLength: 63
								minLength: 1
								type:      "string"
							}
							timeout: {
								description: "Timeout for validation, apply and health checking operations. Defaults to 'Interval' duration."

								type: "string"
							}
							validation: {
								description: "Validate the Kubernetes objects before applying them on the cluster. The validation strategy can be 'client' (local dry-run), 'server' (APIServer dry-run) or 'none'. When 'Force' is 'true', validation will fallback to 'client' if set to 'server' because server-side validation is not supported in this scenario."

								enum: [
									"none",
									"client",
									"server",
								]
								type: "string"
							}
						}
						required: [
							"interval",
							"prune",
							"sourceRef",
						]
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "KustomizationStatus defines the observed state of a kustomization."
						properties: {
							conditions: {
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							lastAppliedRevision: {
								description: "The last successfully applied revision. The revision format for Git sources is <branch|tag>/<commit-sha>."

								type: "string"
							}
							lastAttemptedRevision: {
								description: "LastAttemptedRevision is the revision of the last reconciliation attempt."

								type: "string"
							}
							lastHandledReconcileAt: {
								description: "LastHandledReconcileAt holds the value of the most recent reconcile request value, so a change of the annotation value can be detected."

								type: "string"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last reconciled generation."
								format:      "int64"
								type:        "integer"
							}
							snapshot: {
								description: "The last successfully applied revision metadata."
								properties: {
									checksum: {
										description: "The manifests sha1 checksum."
										type:        "string"
									}
									entries: {
										description: "A list of Kubernetes kinds grouped by namespace."
										items: {
											description: "Snapshot holds the metadata of namespaced Kubernetes objects"

											properties: {
												kinds: {
													additionalProperties: type: "string"
													description: "The list of Kubernetes kinds."
													type:        "object"
												}
												namespace: {
													description: "The namespace of this entry."
													type:        "string"
												}
											}
											required: ["kinds"]
											type: "object"
										}
										type: "array"
									}
								}
								required: [
									"checksum",
									"entries",
								]
								type: "object"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: false
			subresources: status: {}
		}, {
			additionalPrinterColumns: [{
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
				name:     "Ready"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
				name:     "Status"
				type:     "string"
			}]
			deprecated:         true
			deprecationWarning: "v1beta2 Kustomization is deprecated, upgrade to v1"
			name:               "v1beta2"
			schema: openAPIV3Schema: {
				description: "Kustomization is the Schema for the kustomizations API."
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "KustomizationSpec defines the configuration to calculate the desired state from a Source using Kustomize."

						properties: {
							commonMetadata: {
								description: "CommonMetadata specifies the common labels and annotations that are applied to all resources. Any existing label or annotation will be overridden if its key matches a common one."

								properties: {
									annotations: {
										additionalProperties: type: "string"
										description: "Annotations to be added to the object's metadata."
										type:        "object"
									}
									labels: {
										additionalProperties: type: "string"
										description: "Labels to be added to the object's metadata."
										type:        "object"
									}
								}
								type: "object"
							}
							components: {
								description: "Components specifies relative paths to specifications of other Components."

								items: type: "string"
								type: "array"
							}
							decryption: {
								description: "Decrypt Kubernetes secrets before applying them on the cluster."

								properties: {
									provider: {
										description: "Provider is the name of the decryption engine."
										enum: ["sops"]
										type: "string"
									}
									secretRef: {
										description: "The secret name containing the private OpenPGP keys used for decryption."

										properties: name: {
											description: "Name of the referent."
											type:        "string"
										}
										required: ["name"]
										type: "object"
									}
								}
								required: ["provider"]
								type: "object"
							}
							dependsOn: {
								description: "DependsOn may contain a meta.NamespacedObjectReference slice with references to Kustomization resources that must be ready before this Kustomization can be reconciled."

								items: {
									description: "NamespacedObjectReference contains enough information to locate the referenced Kubernetes resource object in any namespace."

									properties: {
										name: {
											description: "Name of the referent."
											type:        "string"
										}
										namespace: {
											description: "Namespace of the referent, when not specified it acts as LocalObjectReference."

											type: "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								type: "array"
							}
							force: {
								default:     false
								description: "Force instructs the controller to recreate resources when patching fails due to an immutable field change."

								type: "boolean"
							}
							healthChecks: {
								description: "A list of resources to be included in the health assessment."
								items: {
									description: "NamespacedObjectKindReference contains enough information to locate the typed referenced Kubernetes resource object in any namespace."

									properties: {
										apiVersion: {
											description: "API version of the referent, if not specified the Kubernetes preferred version will be used."

											type: "string"
										}
										kind: {
											description: "Kind of the referent."
											type:        "string"
										}
										name: {
											description: "Name of the referent."
											type:        "string"
										}
										namespace: {
											description: "Namespace of the referent, when not specified it acts as LocalObjectReference."

											type: "string"
										}
									}
									required: [
										"kind",
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							images: {
								description: "Images is a list of (image name, new name, new tag or digest) for changing image names, tags or digests. This can also be achieved with a patch, but this operator is simpler to specify."

								items: {
									description: "Image contains an image name, a new name, a new tag or digest, which will replace the original name and tag."

									properties: {
										digest: {
											description: "Digest is the value used to replace the original image tag. If digest is present NewTag value is ignored."

											type: "string"
										}
										name: {
											description: "Name is a tag-less image name."
											type:        "string"
										}
										newName: {
											description: "NewName is the value used to replace the original name."

											type: "string"
										}
										newTag: {
											description: "NewTag is the value used to replace the original tag."

											type: "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								type: "array"
							}
							interval: {
								description: "The interval at which to reconcile the Kustomization."
								pattern:     "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
								type:        "string"
							}
							kubeConfig: {
								description: "The KubeConfig for reconciling the Kustomization on a remote cluster. When used in combination with KustomizationSpec.ServiceAccountName, forces the controller to act on behalf of that Service Account at the target cluster. If the --default-service-account flag is set, its value will be used as a controller level fallback for when KustomizationSpec.ServiceAccountName is empty."

								properties: secretRef: {
									description: "SecretRef holds the name of a secret that contains a key with the kubeconfig file as the value. If no key is set, the key will default to 'value'. It is recommended that the kubeconfig is self-contained, and the secret is regularly updated if credentials such as a cloud-access-token expire. Cloud specific `cmd-path` auth helpers will not function without adding binaries and credentials to the Pod that is responsible for reconciling Kubernetes resources."

									properties: {
										key: {
											description: "Key in the Secret, when not specified an implementation-specific default key is used."

											type: "string"
										}
										name: {
											description: "Name of the Secret."
											type:        "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								required: ["secretRef"]
								type: "object"
							}
							patches: {
								description: "Strategic merge and JSON patches, defined as inline YAML objects, capable of targeting objects based on kind, label and annotation selectors."

								items: {
									description: "Patch contains an inline StrategicMerge or JSON6902 patch, and the target the patch should be applied to."

									properties: {
										patch: {
											description: "Patch contains an inline StrategicMerge patch or an inline JSON6902 patch with an array of operation objects."

											type: "string"
										}
										target: {
											description: "Target points to the resources that the patch document should be applied to."

											properties: {
												annotationSelector: {
													description: "AnnotationSelector is a string that follows the label selection expression https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api It matches with the resource annotations."

													type: "string"
												}
												group: {
													description: "Group is the API group to select resources from. Together with Version and Kind it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

													type: "string"
												}
												kind: {
													description: "Kind of the API Group to select resources from. Together with Group and Version it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

													type: "string"
												}
												labelSelector: {
													description: "LabelSelector is a string that follows the label selection expression https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api It matches with the resource labels."

													type: "string"
												}
												name: {
													description: "Name to match resources with."
													type:        "string"
												}
												namespace: {
													description: "Namespace to select resources from."
													type:        "string"
												}
												version: {
													description: "Version of the API Group to select resources from. Together with Group and Kind it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

													type: "string"
												}
											}
											type: "object"
										}
									}
									required: ["patch"]
									type: "object"
								}
								type: "array"
							}
							patchesJson6902: {
								description: "JSON 6902 patches, defined as inline YAML objects. Deprecated: Use Patches instead."

								items: {
									description: "JSON6902Patch contains a JSON6902 patch and the target the patch should be applied to."

									properties: {
										patch: {
											description: "Patch contains the JSON6902 patch document with an array of operation objects."

											items: {
												description: "JSON6902 is a JSON6902 operation object. https://datatracker.ietf.org/doc/html/rfc6902#section-4"
												properties: {
													from: {
														description: "From contains a JSON-pointer value that references a location within the target document where the operation is performed. The meaning of the value depends on the value of Op, and is NOT taken into account by all operations."

														type: "string"
													}
													op: {
														description: "Op indicates the operation to perform. Its value MUST be one of \"add\", \"remove\", \"replace\", \"move\", \"copy\", or \"test\". https://datatracker.ietf.org/doc/html/rfc6902#section-4"

														enum: [
															"test",
															"remove",
															"add",
															"replace",
															"move",
															"copy",
														]
														type: "string"
													}
													path: {
														description: "Path contains the JSON-pointer value that references a location within the target document where the operation is performed. The meaning of the value depends on the value of Op."

														type: "string"
													}
													value: {
														description: "Value contains a valid JSON structure. The meaning of the value depends on the value of Op, and is NOT taken into account by all operations."

														"x-kubernetes-preserve-unknown-fields": true
													}
												}
												required: [
													"op",
													"path",
												]
												type: "object"
											}
											type: "array"
										}
										target: {
											description: "Target points to the resources that the patch document should be applied to."

											properties: {
												annotationSelector: {
													description: "AnnotationSelector is a string that follows the label selection expression https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api It matches with the resource annotations."

													type: "string"
												}
												group: {
													description: "Group is the API group to select resources from. Together with Version and Kind it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

													type: "string"
												}
												kind: {
													description: "Kind of the API Group to select resources from. Together with Group and Version it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

													type: "string"
												}
												labelSelector: {
													description: "LabelSelector is a string that follows the label selection expression https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#api It matches with the resource labels."

													type: "string"
												}
												name: {
													description: "Name to match resources with."
													type:        "string"
												}
												namespace: {
													description: "Namespace to select resources from."
													type:        "string"
												}
												version: {
													description: "Version of the API Group to select resources from. Together with Group and Kind it is capable of unambiguously identifying and/or selecting resources. https://github.com/kubernetes/community/blob/master/contributors/design-proposals/api-machinery/api-group.md"

													type: "string"
												}
											}
											type: "object"
										}
									}
									required: [
										"patch",
										"target",
									]
									type: "object"
								}
								type: "array"
							}
							patchesStrategicMerge: {
								description: "Strategic merge patches, defined as inline YAML objects. Deprecated: Use Patches instead."

								items: "x-kubernetes-preserve-unknown-fields": true
								type: "array"
							}
							path: {
								description: "Path to the directory containing the kustomization.yaml file, or the set of plain YAMLs a kustomization.yaml should be generated for. Defaults to 'None', which translates to the root path of the SourceRef."

								type: "string"
							}
							postBuild: {
								description: "PostBuild describes which actions to perform on the YAML manifest generated by building the kustomize overlay."

								properties: {
									substitute: {
										additionalProperties: type: "string"
										description: "Substitute holds a map of key/value pairs. The variables defined in your YAML manifests that match any of the keys defined in the map will be substituted with the set value. Includes support for bash string replacement functions e.g. ${var:=default}, ${var:position} and ${var/substring/replacement}."

										type: "object"
									}
									substituteFrom: {
										description: "SubstituteFrom holds references to ConfigMaps and Secrets containing the variables and their values to be substituted in the YAML manifests. The ConfigMap and the Secret data keys represent the var names and they must match the vars declared in the manifests for the substitution to happen."

										items: {
											description: "SubstituteReference contains a reference to a resource containing the variables name and value."

											properties: {
												kind: {
													description: "Kind of the values referent, valid values are ('Secret', 'ConfigMap')."

													enum: [
														"Secret",
														"ConfigMap",
													]
													type: "string"
												}
												name: {
													description: "Name of the values referent. Should reside in the same namespace as the referring resource."

													maxLength: 253
													minLength: 1
													type:      "string"
												}
												optional: {
													default:     false
													description: "Optional indicates whether the referenced resource must exist, or whether to tolerate its absence. If true and the referenced resource is absent, proceed as if the resource was present but empty, without any variables defined."

													type: "boolean"
												}
											}
											required: [
												"kind",
												"name",
											]
											type: "object"
										}
										type: "array"
									}
								}
								type: "object"
							}
							prune: {
								description: "Prune enables garbage collection."
								type:        "boolean"
							}
							retryInterval: {
								description: "The interval at which to retry a previously failed reconciliation. When not specified, the controller uses the KustomizationSpec.Interval value to retry failures."

								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
								type:    "string"
							}
							serviceAccountName: {
								description: "The name of the Kubernetes service account to impersonate when reconciling this Kustomization."

								type: "string"
							}
							sourceRef: {
								description: "Reference of the source where the kustomization file is."

								properties: {
									apiVersion: {
										description: "API version of the referent."
										type:        "string"
									}
									kind: {
										description: "Kind of the referent."
										enum: [
											"OCIRepository",
											"GitRepository",
											"Bucket",
										]
										type: "string"
									}
									name: {
										description: "Name of the referent."
										type:        "string"
									}
									namespace: {
										description: "Namespace of the referent, defaults to the namespace of the Kubernetes resource object that contains the reference."

										type: "string"
									}
								}
								required: [
									"kind",
									"name",
								]
								type: "object"
							}
							suspend: {
								description: "This flag tells the controller to suspend subsequent kustomize executions, it does not apply to already started executions. Defaults to false."

								type: "boolean"
							}
							targetNamespace: {
								description: "TargetNamespace sets or overrides the namespace in the kustomization.yaml file."

								maxLength: 63
								minLength: 1
								type:      "string"
							}
							timeout: {
								description: "Timeout for validation, apply and health checking operations. Defaults to 'Interval' duration."

								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
								type:    "string"
							}
							validation: {
								description: "Deprecated: Not used in v1beta2."
								enum: [
									"none",
									"client",
									"server",
								]
								type: "string"
							}
							wait: {
								description: "Wait instructs the controller to check the health of all the reconciled resources. When enabled, the HealthChecks are ignored. Defaults to false."

								type: "boolean"
							}
						}
						required: [
							"interval",
							"prune",
							"sourceRef",
						]
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "KustomizationStatus defines the observed state of a kustomization."
						properties: {
							conditions: {
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							inventory: {
								description: "Inventory contains the list of Kubernetes resource object references that have been successfully applied."

								properties: entries: {
									description: "Entries of Kubernetes resource object references."
									items: {
										description: "ResourceRef contains the information necessary to locate a resource within a cluster."

										properties: {
											id: {
												description: "ID is the string representation of the Kubernetes resource object's metadata, in the format '<namespace>_<name>_<group>_<kind>'."

												type: "string"
											}
											v: {
												description: "Version is the API version of the Kubernetes resource object's kind."

												type: "string"
											}
										}
										required: [
											"id",
											"v",
										]
										type: "object"
									}
									type: "array"
								}
								required: ["entries"]
								type: "object"
							}
							lastAppliedRevision: {
								description: "The last successfully applied revision. Equals the Revision of the applied Artifact from the referenced Source."

								type: "string"
							}
							lastAttemptedRevision: {
								description: "LastAttemptedRevision is the revision of the last reconciliation attempt."

								type: "string"
							}
							lastHandledReconcileAt: {
								description: "LastHandledReconcileAt holds the value of the most recent reconcile request value, so a change of the annotation value can be detected."

								type: "string"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last reconciled generation."
								format:      "int64"
								type:        "integer"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: false
			subresources: status: {}
		}]
	}
}
customresourcedefinition: "ocirepositories.source.toolkit.fluxcd.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.12.0"
		name: "ocirepositories.source.toolkit.fluxcd.io"
	}
	spec: {
		group: "source.toolkit.fluxcd.io"
		names: {
			kind:     "OCIRepository"
			listKind: "OCIRepositoryList"
			plural:   "ocirepositories"
			shortNames: ["ocirepo"]
			singular: "ocirepository"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".spec.url"
				name:     "URL"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
				name:     "Ready"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
				name:     "Status"
				type:     "string"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1beta2"
			schema: openAPIV3Schema: {
				description: "OCIRepository is the Schema for the ocirepositories API"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "OCIRepositorySpec defines the desired state of OCIRepository"
						properties: {
							certSecretRef: {
								description: """
		CertSecretRef can be given the name of a Secret containing either or both of 
		 - a PEM-encoded client certificate (`tls.crt`) and private key (`tls.key`); - a PEM-encoded CA certificate (`ca.crt`) 
		 and whichever are supplied, will be used for connecting to the registry. The client cert and key are useful if you are authenticating with a certificate; the CA cert is useful if you are using a self-signed server certificate. The Secret must be of type `Opaque` or `kubernetes.io/tls`. 
		 Note: Support for the `caFile`, `certFile` and `keyFile` keys have been deprecated.
		"""

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							ignore: {
								description: "Ignore overrides the set of excluded patterns in the .sourceignore format (which is the same as .gitignore). If not provided, a default will be used, consult the documentation for your version to find out what those are."

								type: "string"
							}
							insecure: {
								description: "Insecure allows connecting to a non-TLS HTTP container registry."

								type: "boolean"
							}
							interval: {
								description: "Interval at which the OCIRepository URL is checked for updates. This interval is approximate and may be subject to jitter to ensure efficient use of resources."

								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
								type:    "string"
							}
							layerSelector: {
								description: "LayerSelector specifies which layer should be extracted from the OCI artifact. When not specified, the first layer found in the artifact is selected."

								properties: {
									mediaType: {
										description: "MediaType specifies the OCI media type of the layer which should be extracted from the OCI Artifact. The first layer matching this type is selected."

										type: "string"
									}
									operation: {
										description: "Operation specifies how the selected layer should be processed. By default, the layer compressed content is extracted to storage. When the operation is set to 'copy', the layer compressed content is persisted to storage as it is."

										enum: [
											"extract",
											"copy",
										]
										type: "string"
									}
								}
								type: "object"
							}
							provider: {
								default:     "generic"
								description: "The provider used for authentication, can be 'aws', 'azure', 'gcp' or 'generic'. When not specified, defaults to 'generic'."

								enum: [
									"generic",
									"aws",
									"azure",
									"gcp",
								]
								type: "string"
							}
							ref: {
								description: "The OCI reference to pull and monitor for changes, defaults to the latest tag."

								properties: {
									digest: {
										description: "Digest is the image digest to pull, takes precedence over SemVer. The value should be in the format 'sha256:<HASH>'."

										type: "string"
									}
									semver: {
										description: "SemVer is the range of tags to pull selecting the latest within the range, takes precedence over Tag."

										type: "string"
									}
									tag: {
										description: "Tag is the image tag to pull, defaults to latest."
										type:        "string"
									}
								}
								type: "object"
							}
							secretRef: {
								description: "SecretRef contains the secret name containing the registry login credentials to resolve image metadata. The secret must be of type kubernetes.io/dockerconfigjson."

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							serviceAccountName: {
								description: "ServiceAccountName is the name of the Kubernetes ServiceAccount used to authenticate the image pull if the service account has attached pull secrets. For more information: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#add-imagepullsecrets-to-a-service-account"

								type: "string"
							}
							suspend: {
								description: "This flag tells the controller to suspend the reconciliation of this source."

								type: "boolean"
							}
							timeout: {
								default:     "60s"
								description: "The timeout for remote OCI Repository operations like pulling, defaults to 60s."

								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m))+$"
								type:    "string"
							}
							url: {
								description: "URL is a reference to an OCI artifact repository hosted on a remote container registry."

								pattern: "^oci://.*$"
								type:    "string"
							}
							verify: {
								description: "Verify contains the secret name containing the trusted public keys used to verify the signature and specifies which provider to use to check whether OCI image is authentic."

								properties: {
									matchOIDCIdentity: {
										description: "MatchOIDCIdentity specifies the identity matching criteria to use while verifying an OCI artifact which was signed using Cosign keyless signing. The artifact's identity is deemed to be verified if any of the specified matchers match against the identity."

										items: {
											description: "OIDCIdentityMatch specifies options for verifying the certificate identity, i.e. the issuer and the subject of the certificate."

											properties: {
												issuer: {
													description: "Issuer specifies the regex pattern to match against to verify the OIDC issuer in the Fulcio certificate. The pattern must be a valid Go regular expression."

													type: "string"
												}
												subject: {
													description: "Subject specifies the regex pattern to match against to verify the identity subject in the Fulcio certificate. The pattern must be a valid Go regular expression."

													type: "string"
												}
											}
											required: [
												"issuer",
												"subject",
											]
											type: "object"
										}
										type: "array"
									}
									provider: {
										default:     "cosign"
										description: "Provider specifies the technology used to sign the OCI Artifact."

										enum: ["cosign"]
										type: "string"
									}
									secretRef: {
										description: "SecretRef specifies the Kubernetes Secret containing the trusted public keys."

										properties: name: {
											description: "Name of the referent."
											type:        "string"
										}
										required: ["name"]
										type: "object"
									}
								}
								required: ["provider"]
								type: "object"
							}
						}
						required: [
							"interval",
							"url",
						]
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "OCIRepositoryStatus defines the observed state of OCIRepository"
						properties: {
							artifact: {
								description: "Artifact represents the output of the last successful OCI Repository sync."

								properties: {
									digest: {
										description: "Digest is the digest of the file in the form of '<algorithm>:<checksum>'."
										pattern:     "^[a-z0-9]+(?:[.+_-][a-z0-9]+)*:[a-zA-Z0-9=_-]+$"
										type:        "string"
									}
									lastUpdateTime: {
										description: "LastUpdateTime is the timestamp corresponding to the last update of the Artifact."

										format: "date-time"
										type:   "string"
									}
									metadata: {
										additionalProperties: type: "string"
										description: "Metadata holds upstream information such as OCI annotations."
										type:        "object"
									}
									path: {
										description: "Path is the relative file path of the Artifact. It can be used to locate the file in the root of the Artifact storage on the local file system of the controller managing the Source."

										type: "string"
									}
									revision: {
										description: "Revision is a human-readable identifier traceable in the origin source system. It can be a Git commit SHA, Git tag, a Helm chart version, etc."

										type: "string"
									}
									size: {
										description: "Size is the number of bytes in the file."
										format:      "int64"
										type:        "integer"
									}
									url: {
										description: "URL is the HTTP address of the Artifact as exposed by the controller managing the Source. It can be used to retrieve the Artifact for consumption, e.g. by another controller applying the Artifact contents."

										type: "string"
									}
								}
								required: [
									"lastUpdateTime",
									"path",
									"revision",
									"url",
								]
								type: "object"
							}
							conditions: {
								description: "Conditions holds the conditions for the OCIRepository."
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							contentConfigChecksum: {
								description: """
		ContentConfigChecksum is a checksum of all the configurations related to the content of the source artifact: - .spec.ignore - .spec.layerSelector observed in .status.observedGeneration version of the object. This can be used to determine if the content configuration has changed and the artifact needs to be rebuilt. It has the format of `<algo>:<checksum>`, for example: `sha256:<checksum>`. 
		 Deprecated: Replaced with explicit fields for observed artifact content config in the status.
		"""

								type: "string"
							}
							lastHandledReconcileAt: {
								description: "LastHandledReconcileAt holds the value of the most recent reconcile request value, so a change of the annotation value can be detected."

								type: "string"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last observed generation."
								format:      "int64"
								type:        "integer"
							}
							observedIgnore: {
								description: "ObservedIgnore is the observed exclusion patterns used for constructing the source artifact."

								type: "string"
							}
							observedLayerSelector: {
								description: "ObservedLayerSelector is the observed layer selector used for constructing the source artifact."

								properties: {
									mediaType: {
										description: "MediaType specifies the OCI media type of the layer which should be extracted from the OCI Artifact. The first layer matching this type is selected."

										type: "string"
									}
									operation: {
										description: "Operation specifies how the selected layer should be processed. By default, the layer compressed content is extracted to storage. When the operation is set to 'copy', the layer compressed content is persisted to storage as it is."

										enum: [
											"extract",
											"copy",
										]
										type: "string"
									}
								}
								type: "object"
							}
							url: {
								description: "URL is the download link for the artifact output of the last OCI Repository sync."

								type: "string"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}]
	}
}
customresourcedefinition: "providers.notification.toolkit.fluxcd.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.12.0"
		name: "providers.notification.toolkit.fluxcd.io"
	}
	spec: {
		group: "notification.toolkit.fluxcd.io"
		names: {
			kind:     "Provider"
			listKind: "ProviderList"
			plural:   "providers"
			singular: "provider"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
				name:     "Ready"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
				name:     "Status"
				type:     "string"
			}]
			deprecated:         true
			deprecationWarning: "v1beta1 Provider is deprecated, upgrade to v1beta3"
			name:               "v1beta1"
			schema: openAPIV3Schema: {
				description: "Provider is the Schema for the providers API"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "ProviderSpec defines the desired state of Provider"
						properties: {
							address: {
								description: "HTTP/S webhook address of this provider"
								pattern:     "^(http|https)://"
								type:        "string"
							}
							certSecretRef: {
								description: "CertSecretRef can be given the name of a secret containing a PEM-encoded CA certificate (`caFile`)"

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							channel: {
								description: "Alert channel for this provider"
								type:        "string"
							}
							proxy: {
								description: "HTTP/S address of the proxy"
								pattern:     "^(http|https)://"
								type:        "string"
							}
							secretRef: {
								description: "Secret reference containing the provider webhook URL using \"address\" as data key"

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							suspend: {
								description: "This flag tells the controller to suspend subsequent events handling. Defaults to false."

								type: "boolean"
							}
							timeout: {
								description: "Timeout for sending alerts to the provider."
								pattern:     "^([0-9]+(\\.[0-9]+)?(ms|s|m))+$"
								type:        "string"
							}
							type: {
								description: "Type of provider"
								enum: [
									"slack",
									"discord",
									"msteams",
									"rocket",
									"generic",
									"generic-hmac",
									"github",
									"gitlab",
									"bitbucket",
									"azuredevops",
									"googlechat",
									"webex",
									"sentry",
									"azureeventhub",
									"telegram",
									"lark",
									"matrix",
									"opsgenie",
									"alertmanager",
									"grafana",
									"githubdispatch",
								]
								type: "string"
							}
							username: {
								description: "Bot username for this provider"
								type:        "string"
							}
						}
						required: ["type"]
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "ProviderStatus defines the observed state of Provider"
						properties: {
							conditions: {
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last reconciled generation."
								format:      "int64"
								type:        "integer"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: false
			subresources: status: {}
		}, {
			additionalPrinterColumns: [{
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
				name:     "Ready"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
				name:     "Status"
				type:     "string"
			}]
			deprecated:         true
			deprecationWarning: "v1beta2 Provider is deprecated, upgrade to v1beta3"
			name:               "v1beta2"
			schema: openAPIV3Schema: {
				description: "Provider is the Schema for the providers API."
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "ProviderSpec defines the desired state of the Provider."
						properties: {
							address: {
								description: "Address specifies the endpoint, in a generic sense, to where alerts are sent. What kind of endpoint depends on the specific Provider type being used. For the generic Provider, for example, this is an HTTP/S address. For other Provider types this could be a project ID or a namespace."

								maxLength: 2048
								type:      "string"
							}
							certSecretRef: {
								description: """
		CertSecretRef specifies the Secret containing a PEM-encoded CA certificate (in the `ca.crt` key). 
		 Note: Support for the `caFile` key has been deprecated.
		"""

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							channel: {
								description: "Channel specifies the destination channel where events should be posted."

								maxLength: 2048
								type:      "string"
							}
							interval: {
								description: "Interval at which to reconcile the Provider with its Secret references."

								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
								type:    "string"
							}
							proxy: {
								description: "Proxy the HTTP/S address of the proxy server."
								maxLength:   2048
								pattern:     "^(http|https)://.*$"
								type:        "string"
							}
							secretRef: {
								description: "SecretRef specifies the Secret containing the authentication credentials for this Provider."

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							suspend: {
								description: "Suspend tells the controller to suspend subsequent events handling for this Provider."

								type: "boolean"
							}
							timeout: {
								description: "Timeout for sending alerts to the Provider."
								pattern:     "^([0-9]+(\\.[0-9]+)?(ms|s|m))+$"
								type:        "string"
							}
							type: {
								description: "Type specifies which Provider implementation to use."
								enum: [
									"slack",
									"discord",
									"msteams",
									"rocket",
									"generic",
									"generic-hmac",
									"github",
									"gitlab",
									"gitea",
									"bitbucketserver",
									"bitbucket",
									"azuredevops",
									"googlechat",
									"googlepubsub",
									"webex",
									"sentry",
									"azureeventhub",
									"telegram",
									"lark",
									"matrix",
									"opsgenie",
									"alertmanager",
									"grafana",
									"githubdispatch",
									"pagerduty",
									"datadog",
								]
								type: "string"
							}
							username: {
								description: "Username specifies the name under which events are posted."
								maxLength:   2048
								type:        "string"
							}
						}
						required: ["type"]
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "ProviderStatus defines the observed state of the Provider."
						properties: {
							conditions: {
								description: "Conditions holds the conditions for the Provider."
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							lastHandledReconcileAt: {
								description: "LastHandledReconcileAt holds the value of the most recent reconcile request value, so a change of the annotation value can be detected."

								type: "string"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last reconciled generation."
								format:      "int64"
								type:        "integer"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: false
			subresources: status: {}
		}, {
			additionalPrinterColumns: [{
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1beta3"
			schema: openAPIV3Schema: {
				description: "Provider is the Schema for the providers API"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "ProviderSpec defines the desired state of the Provider."
						properties: {
							address: {
								description: "Address specifies the endpoint, in a generic sense, to where alerts are sent. What kind of endpoint depends on the specific Provider type being used. For the generic Provider, for example, this is an HTTP/S address. For other Provider types this could be a project ID or a namespace."

								maxLength: 2048
								type:      "string"
							}
							certSecretRef: {
								description: """
		CertSecretRef specifies the Secret containing a PEM-encoded CA certificate (in the `ca.crt` key). 
		 Note: Support for the `caFile` key has been deprecated.
		"""

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							channel: {
								description: "Channel specifies the destination channel where events should be posted."

								maxLength: 2048
								type:      "string"
							}
							interval: {
								description: "Interval at which to reconcile the Provider with its Secret references. Deprecated and not used in v1beta3."

								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
								type:    "string"
							}
							proxy: {
								description: "Proxy the HTTP/S address of the proxy server."
								maxLength:   2048
								pattern:     "^(http|https)://.*$"
								type:        "string"
							}
							secretRef: {
								description: "SecretRef specifies the Secret containing the authentication credentials for this Provider."

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							suspend: {
								description: "Suspend tells the controller to suspend subsequent events handling for this Provider."

								type: "boolean"
							}
							timeout: {
								description: "Timeout for sending alerts to the Provider."
								pattern:     "^([0-9]+(\\.[0-9]+)?(ms|s|m))+$"
								type:        "string"
							}
							type: {
								description: "Type specifies which Provider implementation to use."
								enum: [
									"slack",
									"discord",
									"msteams",
									"rocket",
									"generic",
									"generic-hmac",
									"github",
									"gitlab",
									"gitea",
									"bitbucketserver",
									"bitbucket",
									"azuredevops",
									"googlechat",
									"googlepubsub",
									"webex",
									"sentry",
									"azureeventhub",
									"telegram",
									"lark",
									"matrix",
									"opsgenie",
									"alertmanager",
									"grafana",
									"githubdispatch",
									"pagerduty",
									"datadog",
									"nats",
								]
								type: "string"
							}
							username: {
								description: "Username specifies the name under which events are posted."
								maxLength:   2048
								type:        "string"
							}
						}
						required: ["type"]
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: true
			subresources: {}
		}]
	}
}
customresourcedefinition: "receivers.notification.toolkit.fluxcd.io": {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinition"
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.12.0"
		name: "receivers.notification.toolkit.fluxcd.io"
	}
	spec: {
		group: "notification.toolkit.fluxcd.io"
		names: {
			kind:     "Receiver"
			listKind: "ReceiverList"
			plural:   "receivers"
			singular: "receiver"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
				name:     "Ready"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
				name:     "Status"
				type:     "string"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				description: "Receiver is the Schema for the receivers API."
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "ReceiverSpec defines the desired state of the Receiver."
						properties: {
							events: {
								description: "Events specifies the list of event types to handle, e.g. 'push' for GitHub or 'Push Hook' for GitLab."

								items: type: "string"
								type: "array"
							}
							interval: {
								default:     "10m"
								description: "Interval at which to reconcile the Receiver with its Secret references."

								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
								type:    "string"
							}
							resources: {
								description: "A list of resources to be notified about changes."
								items: {
									description: "CrossNamespaceObjectReference contains enough information to let you locate the typed referenced object at cluster level"

									properties: {
										apiVersion: {
											description: "API version of the referent"
											type:        "string"
										}
										kind: {
											description: "Kind of the referent"
											enum: [
												"Bucket",
												"GitRepository",
												"Kustomization",
												"HelmRelease",
												"HelmChart",
												"HelmRepository",
												"ImageRepository",
												"ImagePolicy",
												"ImageUpdateAutomation",
												"OCIRepository",
											]
											type: "string"
										}
										matchLabels: {
											additionalProperties: type: "string"
											description: "MatchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed. MatchLabels requires the name to be set to `*`."

											type: "object"
										}
										name: {
											description: "Name of the referent If multiple resources are targeted `*` may be set."

											maxLength: 53
											minLength: 1
											type:      "string"
										}
										namespace: {
											description: "Namespace of the referent"
											maxLength:   53
											minLength:   1
											type:        "string"
										}
									}
									required: [
										"kind",
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							secretRef: {
								description: "SecretRef specifies the Secret containing the token used to validate the payload authenticity."

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							suspend: {
								description: "Suspend tells the controller to suspend subsequent events handling for this receiver."

								type: "boolean"
							}
							type: {
								description: "Type of webhook sender, used to determine the validation procedure and payload deserialization."

								enum: [
									"generic",
									"generic-hmac",
									"github",
									"gitlab",
									"bitbucket",
									"harbor",
									"dockerhub",
									"quay",
									"gcr",
									"nexus",
									"acr",
								]
								type: "string"
							}
						}
						required: [
							"resources",
							"secretRef",
							"type",
						]
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "ReceiverStatus defines the observed state of the Receiver."
						properties: {
							conditions: {
								description: "Conditions holds the conditions for the Receiver."
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							lastHandledReconcileAt: {
								description: "LastHandledReconcileAt holds the value of the most recent reconcile request value, so a change of the annotation value can be detected."

								type: "string"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last observed generation of the Receiver object."

								format: "int64"
								type:   "integer"
							}
							webhookPath: {
								description: "WebhookPath is the generated incoming webhook address in the format of '/hook/sha256sum(token+name+namespace)'."

								type: "string"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: true
			subresources: status: {}
		}, {
			additionalPrinterColumns: [{
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
				name:     "Ready"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
				name:     "Status"
				type:     "string"
			}]
			deprecated:         true
			deprecationWarning: "v1beta1 Receiver is deprecated, upgrade to v1"
			name:               "v1beta1"
			schema: openAPIV3Schema: {
				description: "Receiver is the Schema for the receivers API"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "ReceiverSpec defines the desired state of Receiver"
						properties: {
							events: {
								description: "A list of events to handle, e.g. 'push' for GitHub or 'Push Hook' for GitLab."

								items: type: "string"
								type: "array"
							}
							resources: {
								description: "A list of resources to be notified about changes."
								items: {
									description: "CrossNamespaceObjectReference contains enough information to let you locate the typed referenced object at cluster level"

									properties: {
										apiVersion: {
											description: "API version of the referent"
											type:        "string"
										}
										kind: {
											description: "Kind of the referent"
											enum: [
												"Bucket",
												"GitRepository",
												"Kustomization",
												"HelmRelease",
												"HelmChart",
												"HelmRepository",
												"ImageRepository",
												"ImagePolicy",
												"ImageUpdateAutomation",
												"OCIRepository",
											]
											type: "string"
										}
										matchLabels: {
											additionalProperties: type: "string"
											description: "MatchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."

											type: "object"
										}
										name: {
											description: "Name of the referent"
											maxLength:   53
											minLength:   1
											type:        "string"
										}
										namespace: {
											description: "Namespace of the referent"
											maxLength:   53
											minLength:   1
											type:        "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								type: "array"
							}
							secretRef: {
								description: "Secret reference containing the token used to validate the payload authenticity"

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							suspend: {
								description: "This flag tells the controller to suspend subsequent events handling. Defaults to false."

								type: "boolean"
							}
							type: {
								description: "Type of webhook sender, used to determine the validation procedure and payload deserialization."

								enum: [
									"generic",
									"generic-hmac",
									"github",
									"gitlab",
									"bitbucket",
									"harbor",
									"dockerhub",
									"quay",
									"gcr",
									"nexus",
									"acr",
								]
								type: "string"
							}
						}
						required: [
							"resources",
							"type",
						]
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "ReceiverStatus defines the observed state of Receiver"
						properties: {
							conditions: {
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last observed generation."
								format:      "int64"
								type:        "integer"
							}
							url: {
								description: "Generated webhook URL in the format of '/hook/sha256sum(token+name+namespace)'."
								type:        "string"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: false
			subresources: status: {}
		}, {
			additionalPrinterColumns: [{
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].status"
				name:     "Ready"
				type:     "string"
			}, {
				jsonPath: ".status.conditions[?(@.type==\"Ready\")].message"
				name:     "Status"
				type:     "string"
			}]
			deprecated:         true
			deprecationWarning: "v1beta2 Receiver is deprecated, upgrade to v1"
			name:               "v1beta2"
			schema: openAPIV3Schema: {
				description: "Receiver is the Schema for the receivers API."
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"

						type: "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"

						type: "string"
					}
					metadata: type: "object"
					spec: {
						description: "ReceiverSpec defines the desired state of the Receiver."
						properties: {
							events: {
								description: "Events specifies the list of event types to handle, e.g. 'push' for GitHub or 'Push Hook' for GitLab."

								items: type: "string"
								type: "array"
							}
							interval: {
								description: "Interval at which to reconcile the Receiver with its Secret references."

								pattern: "^([0-9]+(\\.[0-9]+)?(ms|s|m|h))+$"
								type:    "string"
							}
							resources: {
								description: "A list of resources to be notified about changes."
								items: {
									description: "CrossNamespaceObjectReference contains enough information to let you locate the typed referenced object at cluster level"

									properties: {
										apiVersion: {
											description: "API version of the referent"
											type:        "string"
										}
										kind: {
											description: "Kind of the referent"
											enum: [
												"Bucket",
												"GitRepository",
												"Kustomization",
												"HelmRelease",
												"HelmChart",
												"HelmRepository",
												"ImageRepository",
												"ImagePolicy",
												"ImageUpdateAutomation",
												"OCIRepository",
											]
											type: "string"
										}
										matchLabels: {
											additionalProperties: type: "string"
											description: "MatchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed. MatchLabels requires the name to be set to `*`."

											type: "object"
										}
										name: {
											description: "Name of the referent If multiple resources are targeted `*` may be set."

											maxLength: 53
											minLength: 1
											type:      "string"
										}
										namespace: {
											description: "Namespace of the referent"
											maxLength:   53
											minLength:   1
											type:        "string"
										}
									}
									required: [
										"kind",
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							secretRef: {
								description: "SecretRef specifies the Secret containing the token used to validate the payload authenticity."

								properties: name: {
									description: "Name of the referent."
									type:        "string"
								}
								required: ["name"]
								type: "object"
							}
							suspend: {
								description: "Suspend tells the controller to suspend subsequent events handling for this receiver."

								type: "boolean"
							}
							type: {
								description: "Type of webhook sender, used to determine the validation procedure and payload deserialization."

								enum: [
									"generic",
									"generic-hmac",
									"github",
									"gitlab",
									"bitbucket",
									"harbor",
									"dockerhub",
									"quay",
									"gcr",
									"nexus",
									"acr",
								]
								type: "string"
							}
						}
						required: [
							"resources",
							"type",
						]
						type: "object"
					}
					status: {
						default: observedGeneration: -1
						description: "ReceiverStatus defines the observed state of the Receiver."
						properties: {
							conditions: {
								description: "Conditions holds the conditions for the Receiver."
								items: {
									description: """
		Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, 
		 type FooStatus struct{ // Represents the observations of a foo's current state. // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\" // +patchMergeKey=type // +patchStrategy=merge // +listType=map // +listMapKey=type Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` 
		 // other fields }
		"""

									properties: {
										lastTransitionTime: {
											description: "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."

											format: "date-time"
											type:   "string"
										}
										message: {
											description: "message is a human readable message indicating details about the transition. This may be an empty string."

											maxLength: 32768
											type:      "string"
										}
										observedGeneration: {
											description: "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."

											format:  "int64"
											minimum: 0
											type:    "integer"
										}
										reason: {
											description: "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."

											maxLength: 1024
											minLength: 1
											pattern:   "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
											type:      "string"
										}
										status: {
											description: "status of the condition, one of True, False, Unknown."
											enum: [
												"True",
												"False",
												"Unknown",
											]
											type: "string"
										}
										type: {
											description: "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"

											maxLength: 316
											pattern:   "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
											type:      "string"
										}
									}
									required: [
										"lastTransitionTime",
										"message",
										"reason",
										"status",
										"type",
									]
									type: "object"
								}
								type: "array"
							}
							lastHandledReconcileAt: {
								description: "LastHandledReconcileAt holds the value of the most recent reconcile request value, so a change of the annotation value can be detected."

								type: "string"
							}
							observedGeneration: {
								description: "ObservedGeneration is the last observed generation of the Receiver object."

								format: "int64"
								type:   "integer"
							}
							url: {
								description: "URL is the generated incoming webhook address in the format of '/hook/sha256sum(token+name+namespace)'. Deprecated: Replaced by WebhookPath."

								type: "string"
							}
							webhookPath: {
								description: "WebhookPath is the generated incoming webhook address in the format of '/hook/sha256sum(token+name+namespace)'."

								type: "string"
							}
						}
						type: "object"
					}
				}
				type: "object"
			}
			served:  true
			storage: false
			subresources: status: {}
		}]
	}
}
