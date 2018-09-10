#!jinja|yaml|gpg

cloud:
  providers:
    proxint:
      driver: proxmox
      url: prox.domain.tld
      host: prd-prox-01
      image: 'local:vztmpl/debian-9.0-standard_9.3-1_amd64.tar.gz'
      script: proxint_deploy
      user: |
          -----BEGIN PGP MESSAGE-----

          hQIMA9RfKrevXiv4ARAAqI7xhc9lbwZKFeuV7Q4E06MlvZpqCRf+v2q7X4NOBD6g
          5JqvO/TU22WnEzNwHAxqcvvh4cb0vrjlL5L1NjFTsn57pLV3sFfYxqLykS4XpPId
          wpQrPM7jD7VhtUw9HccRiApjyM0DE0n7+UN0JEFJPDKTy+H7CgK8hvihkUK9LeXe
          chsd0n01QiPuXyHNurTSlodJtE0QStc6mciRdg4dMfpVgcfMzmANIt+RI5pNI4EV
          vurjh0m7gU9sxWVdoVERNckJMsTsR6SiY9LgQBxnrGXsavURzWm/2oGMt9AppsiN
          pWlbFUS9hXQ26+AE+TfdwEg69QUehyZcDWFioPACigFSH5ePbCKUXfJgVnJb76De
          CASUBZT/EsO1i3FAk0SmA2tFFJMYUI0Iqst4WGpx13PuygqWPQ78mkTKK89FRLSf
          SAEztMDbMHRhQoVN72h4hB86gb1JXpB/QLqhQTgUsbbvCEUQP36pdglNwsWpQ8mt
          TIo0M62BGYmDCZu/NWEPK82bn7hyp9j8Kg==
          =ZqMr
          -----END PGP MESSAGE-----
      password: |
          -----BEGIN PGP MESSAGE-----

          hQIMA9RfKrevXiv4AQ/+N6heDjlWhugumL2C5Y6GOKKKLW1svdDhg92zYzXenh7P
          0pMkcYo+ZzPnnKPkc1v/2hVUCWfqFOapj5lPzSGe79fghvUaLCEXSUEvTZYRV3lw
          27IQ30peZu5u8uM7tO5M8Y0aQOg0H7MkhtrhRCqVFCrD08f6130DTbx8aF7La4cS
          hSqVSgBY9hiRyIkvtfjiavrz5P9oWkB/ZH48uodkyAkPipJwtem9GVHyIzwdARDD
          2rTkbl/Hm+bRwJ+ikY5nGJ8YtEpk/jPKt997WnOi1Wn+To7osmq1QzZYiWDqhDKF
          keMvaaxyomOjif+g+IIfAI2fGNlr/CuPIz+VbuZgKKgmwZPImrlBLXh4oxB7JeFO
          nSAxOijvl+mu6AVYkbx1TFf2SD4Sej4WzSL9M+8BZSSVXZOLtV+XXRxPkktW/xpN
          XAFxfRzDB1cnbySqmOELKU5sE9NCUUxTSbzadrMl/w9Xb0GXU6r6wDpdheVxSiW2
          0E3pDWXoXfQvvk6nhVsDkg+ume/JiMbw/P/MhrId6lmtioswdINhjegBjOQP
          =EIY0
          -----END PGP MESSAGE-----
