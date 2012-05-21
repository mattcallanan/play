newtype MaybeT f a = MaybeT {runMaybeT :: f (Maybe a)}

instance (Monad f) => Monad (MaybeT f) where
    -- a -> MaybeT (f a)
    return a = MaybeT (return (Just a))
    (MaybeT a) >>= f =
        MaybeT $ a >>= maybe (return Nothing)
                              (runMaybeT . f)
